$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$listener = $null
$prefix = $null

$ports = @(8000, 8001, 8002, 8080, 8081)
foreach ($port in $ports) {
    $candidate = "http://localhost:$port/"
    $candidateListener = [System.Net.HttpListener]::new()
    try {
        $candidateListener.Prefixes.Add($candidate)
        $candidateListener.Start()
        $listener = $candidateListener
        $prefix = $candidate
        break
    }
    catch [System.Net.HttpListenerException] {
        $candidateListener.Close()
        $candidateListener.Dispose()
    }
}

if (-not $listener -or -not $prefix) {
    throw "Could not start a local HTTP server on any of the available ports."
}

Write-Host "Serving $root at $prefix"

function Convert-MarkdownToHtml {
    param([string]$Markdown)

    function Convert-InlineMarkdown {
        param([string]$Text)

        $escaped = [System.Net.WebUtility]::HtmlEncode($Text)
        $escaped = $escaped -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
        $escaped = $escaped -replace '\*(.+?)\*', '<em>$1</em>'
        $escaped = $escaped -replace '\[(.+?)\]\((.+?)\)', '<a href="$2">$1</a>'
        $escaped = $escaped -replace '`([^`]+)`', '<code>$1</code>'
        return $escaped
    }

    $lines = $Markdown -split "`r?`n"
    $htmlLines = New-Object System.Collections.Generic.List[string]
    $inList = $false
    $inCodeBlock = $false
    $codeLines = New-Object System.Collections.Generic.List[string]

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if ($line -match '^```') {
            if ($inCodeBlock) {
                $htmlLines.Add("<pre><code>$([System.Net.WebUtility]::HtmlEncode(($codeLines -join [Environment]::NewLine)))</code></pre>")
                $codeLines.Clear()
                $inCodeBlock = $false
            }
            else {
                if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
                $inCodeBlock = $true
            }
            continue
        }

        if ($inCodeBlock) {
            $codeLines.Add($line)
            continue
        }

        if ($line -match '^#\s+(.*)$') {
            if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
            $htmlLines.Add("<h1>$(Convert-InlineMarkdown -Text $matches[1])</h1>")
        }
        elseif ($line -match '^##\s+(.*)$') {
            if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
            $htmlLines.Add("<h2>$(Convert-InlineMarkdown -Text $matches[1])</h2>")
        }
        elseif ($line -match '^###\s+(.*)$') {
            if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
            $htmlLines.Add("<h3>$(Convert-InlineMarkdown -Text $matches[1])</h3>")
        }
        elseif ($line -match '^-\s+(.*)$') {
            if (-not $inList) { $htmlLines.Add('<ul>'); $inList = $true }
            $htmlLines.Add("<li>$(Convert-InlineMarkdown -Text $matches[1])</li>")
        }
        elseif ($line.Trim() -eq '') {
            if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
        }
        else {
            if ($inList) { $htmlLines.Add('</ul>'); $inList = $false }
            $htmlLines.Add("<p>$(Convert-InlineMarkdown -Text $line)</p>")
        }
    }

    if ($inList) { $htmlLines.Add('</ul>') }
    if ($inCodeBlock) { $htmlLines.Add("<pre><code>$([System.Net.WebUtility]::HtmlEncode(($codeLines -join [Environment]::NewLine)))</code></pre>") }

    return '<!DOCTYPE html><html><head><meta charset="utf-8" /><title>Markdown Preview</title><style>body{font-family:Segoe UI,Arial,sans-serif;line-height:1.5;margin:2rem;max-width:900px;}code{background:#f3f3f3;padding:2px 4px;border-radius:3px;}pre{background:#f3f3f3;padding:1rem;border-radius:4px;overflow:auto;}a{color:#0366d6;text-decoration:none;}a:hover{text-decoration:underline;}</style></head><body>' + ($htmlLines -join [Environment]::NewLine) + '</body></html>'
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $requestPath = $context.Request.Url.AbsolutePath
        $localPath = [System.Uri]::UnescapeDataString($requestPath.TrimStart('/'))
        $fullPath = Join-Path $root $localPath

        if ([string]::IsNullOrWhiteSpace($localPath) -or $localPath -eq '/') {
            $fullPath = Join-Path $root 'index.md'
        }

        if (-not [System.IO.Path]::GetFullPath($fullPath).StartsWith([System.IO.Path]::GetFullPath($root))) {
            $response = $context.Response
            $response.StatusCode = 403
            $response.Close()
            continue
        }

        if (Test-Path $fullPath -PathType Container) {
            $fullPath = Join-Path $fullPath 'index.md'
        }

        if (Test-Path $fullPath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllText($fullPath)
            $response = $context.Response

            if ($fullPath.EndsWith('.md')) {
                $html = Convert-MarkdownToHtml -Markdown $content
                $bytes = [System.Text.Encoding]::UTF8.GetBytes($html)
                $response.ContentType = 'text/html; charset=utf-8'
                $response.ContentLength64 = $bytes.Length
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
                $response.OutputStream.Close()
            }
            elseif ($fullPath.EndsWith('.html')) {
                $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
                $response.ContentType = 'text/html; charset=utf-8'
                $response.ContentLength64 = $bytes.Length
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
                $response.OutputStream.Close()
            }
            else {
                $bytes = [System.IO.File]::ReadAllBytes($fullPath)
                $response.ContentType = 'application/octet-stream'
                $response.ContentLength64 = $bytes.Length
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
                $response.OutputStream.Close()
            }
        }
        else {
            $response = $context.Response
            $response.StatusCode = 404
            $response.Close()
        }
    }
}
finally {
    if ($listener) {
        try { $listener.Stop() } catch {}
        try { $listener.Close() } catch {}
        try { $listener.Dispose() } catch {}
    }
}
