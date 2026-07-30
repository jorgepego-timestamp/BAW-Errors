[Índice](./index.md) | 
[Processo de Cotações](./ProcessoCotacoes.md) | 
[Toolkits](./Toolkits.md)  


# [VICRL] Victoria Rules

## Service Flow(2 errors)

### Obter Contexto e SubContexto RAD (1 error)
- The external service 'CERNService' is unavailable. Make sure it exists in the process application or toolkit. If it exists in another toolkit, ensure that the toolkit is included as a dependency.
  - Removed box from service "CERN - Contexto e SubContexto RAD", and added again with "[CSP] Evaluate Rule" implementation and remmapped parameters

### Obter Perfis por Contexto e SubContexto RAD (1 error)
- The external service 'CERNService' is unavailable. Make sure it exists in the process application or toolkit. If it exists in another toolkit, ensure that the toolkit is included as a dependency.
  - Removed box from service "CERN - Contexto e SubContexto RAD", and added again with "[CSP] Evaluate Rule" implementation and remmapped parameters

# [CSP] Core Proxy Services

## VALIDATION - Business Object(1 warning)

### SendFileRequestType(1 warning)
- The 'metadata' name is also used as the name of a business object function. To retrieve or update the property value, you must call getPropertyValue() and setPropertyValue(). Consider using a different name.
- NOT-FIXED: Changes in i/o interface Will break, where component is used

## VALIDATION - Service Flow(5 warnings)

### Service Flow TESTE(2 warnings)
- No input parameter mapping found for parameter without default: aggregations
  - Changed input to null
- No input parameter mapping found for parameter without default: aggregationsOnly
  - Changed input to null

### Generate Doc (1 warning)
- The 'metadata' name is also used as the name of a business object function. To retrieve or update the property value, you must call getPropertyValue() and setPropertyValue(). Consider using a different name.
- NOT-FIXED: Changes in i/o interface Will break, where component is used

### Get File (1 warning)
- The 'metadata' name is also used as the name of a business object function. To retrieve or update the property value, you must call getPropertyValue() and setPropertyValue(). Consider using a different name.
- NOT-FIXED: Changes in i/o interface Will break, where component is used

### Send File (1 warning)
- The 'metadata' name is also used as the name of a business object function. To retrieve or update the property value, you must call getPropertyValue() and setPropertyValue(). Consider using a different name.
- NOT-FIXED: Changes in i/o interface Will break, where component is used

# [VICGC] Victoria Gestão de Contratos

## VALIDATION - Service Flow(1 error)

### GetBlackList(1 error)
- Must be valid JavaScript identifier. It has to start with letter or '_' and to contain only letters, digits or '_'
  - Added Error_Code to Error component

# [VICCOT] Victoria Cotacoes

## VALIDATION - Service Flow(1 error)

### StartCoreWorkFlow(1 error)
- Must be valid JavaScript identifier. It has to start with letter or '_' and to contain only letters, digits or '_'
  - Added Error_Code to Error component

# [TCV] Toolkit - Componentes Victoria

## VALIDATION - Heritage Human Service(1 error, 12 warnings)

### Date Time Picker Example(4 warnings)
- No input parameter mapping found for parameter without default: iEvento
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedAplicacao
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedSistema
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedUser
  - Changed input to null

### Selection Example(1 error)
- Selection 2 is unreachable: [64.1b42173f-4288-40d3-9e62-c9417ea883a7:1b42173f-4288-40d3-9e62-c9417ea883a7]. Make sure it exists in the process application or toolkit. If it exists in another toolkit, ensure that the toolkit is included as a dependency.
  - Removed unavailable view from coach

### Test Filtering Select(4 warnings)
- No input parameter mapping found for parameter without default: iDate
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedUser
  - Changed input to null
- No input parameter mapping found for parameter without default: pageParams
  - Changed input to null
- No input parameter mapping found for parameter without default: user
  - Changed input to null

### Teste Validações(4 warnings)
- No input parameter mapping found for parameter without default: iEvento
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedAplicacao
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedSistema
  - Changed input to null
- No input parameter mapping found for parameter without default: iSelectedUser
  - Changed input to null

## VALIDATION - View(2 errors)

### DocumentListExt(1 error)
- Obter Descricao Propriedades is unreachable: [processId:e56dc9ae-de52-4e01-b7e4-229a6b285275]. Make sure it exists in the process application or toolkit. If it exists in another toolkit, ensure that the toolkit is included as a dependency.
  - remmaped configuration service to "Obter Descriçao Propriedades"

### DocumentListExt BACKUP(1 error)
- Obter Descricao Propriedades is unreachable: [processId:e56dc9ae-de52-4e01-b7e4-229a6b285275]. Make sure it exists in the process application or toolkit. If it exists in another toolkit, ensure that the toolkit is included as a dependency.
  - remmaped configuration service to "Obter Descriçao Propriedades"

## VALIDATION - Service Flow(5 errors)

### Obter Descricao Propriedades(5 errors)
- O serviço anexado não está acessível.
  - NOT-FIXED: Cannot found error source
- Obter_LinhasNegocio_SE não está acessível: [attachedProcessRef:e208706c-406d-40c4-a2ea-9e69529a6c82]. Certifique-se de que existe na process application ou no toolkit. Se existir outro toolkit, certifique-se de que o toolkit está incluído como uma dependência.
  - NOT-FIXED: Not found suitable service to be mapped
- Opcoes_ProdutosNegocio_SE não está acessível: [attachedProcessRef:412f5523-4e59-4c83-b72c-9aebd29773d6]. Certifique-se de que existe na process application ou no toolkit. Se existir outro toolkit, certifique-se de que o toolkit está incluído como uma dependência.
  - NOT-FIXED: Not found suitable service to be mapped
- Opcoes_TiposDocumentos_SE não está acessível: [attachedProcessRef:f84e9d8e-45a4-48ea-bb96-40e595dc4e5a]. Certifique-se de que existe na process application ou no toolkit. Se existir outro toolkit, certifique-se de que o toolkit está incluído como uma dependência.
  - NOT-FIXED: Not found suitable service to be mapped
- Opcoes_VisibilidadeComentario_SE não está acessível: [attachedProcessRef:6b3f4fd0-d91e-4216-8282-575fbb61e74a]. Certifique-se de que existe na process application ou no toolkit. Se existir outro toolkit, certifique-se de que o toolkit está incluído como uma dependência
  - NOT-FIXED: Not found suitable service to be mapped