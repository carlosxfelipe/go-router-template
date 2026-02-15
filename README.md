# go_router_template

Este projeto é um template base para projetos Flutter utilizando `go_router`.

## Status

Em desenvolvimento.

## Como usar este template

Siga os passos abaixo para aplicar este template a um novo projeto Flutter:

1. **Crie um novo projeto Flutter:**

   ```bash
   flutter create nome_do_projeto
   cd nome_do_projeto
   ```

2. **Adicione as dependências necessárias:**
   No `pubspec.yaml`, inclua:

   ```yaml
   dependencies:
     go_router: ^X.X.X
   ```

   > Substitua `X.X.X` pela versão desejada ou mais recente.

   Em seguida, execute:

   ```bash
   flutter pub get
   ```

3. **Substitua a pasta `lib`:**
   - Apague completamente a pasta `lib` do novo projeto.
   - Copie a pasta `lib` deste repositório (`go_router_template`) para o novo projeto.

4. **Ajuste os imports:**
   Altere todos os imports que usam este nome:
   ```dart
   import 'package:go_router_template/widgets.dart';
   ```
   Para refletir o nome do seu projeto:
   ```dart
   import 'package:seu_projeto/widgets.dart';
   ```
   > Dica: utilize a funcionalidade de "Find and Replace" do seu editor para facilitar essa substituição.
