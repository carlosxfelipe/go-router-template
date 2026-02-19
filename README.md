# go_router_template

Este projeto é um template base para projetos Flutter utilizando `go_router` e um conjunto completo de componentes customizados inspirados no **shadcn/ui**.

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

---

## Componentes Customizados

Este template inclui **24 componentes** customizados inspirados no **shadcn/ui**, otimizados para mobile e com suporte completo a temas dark/light. Todos os componentes estão disponíveis através do import `package:go_router_template/widgets.dart`.

### Componentes Essenciais

#### 1. **Input**

Campo de texto completo com suporte a labels, placeholders, ícones, validação e estados de erro.

```dart
Input(
  label: 'Email',
  placeholder: 'Digite seu email',
  prefixIcon: Icons.email,
  errorText: 'Email inválido',
)
```

#### 2. **Button**

Botões primários e outlined com suporte a ícones e estados disabled.

```dart
Button(
  label: 'Confirmar',
  icon: Icons.check,
  onPressed: () {},
)

Button(
  label: 'Cancelar',
  outlined: true,
  onPressed: () {},
)
```

#### 3. **CustomBadge**

Tags/labels com 6 variantes de cores.

```dart
CustomBadge(
  label: 'Novo',
  variant: BadgeVariant.success,
)
```

Variantes disponíveis: `default_`, `secondary`, `success`, `warning`, `error`, `info`.

#### 4. **CustomCard**

Container estilizado com borda e padding, com suporte a interação.

```dart
CustomCard(
  onTap: () {},
  child: Text('Conteúdo do card'),
)
```

#### 5. **Separator**

Divisor horizontal customizável.

```dart
Separator()
```

#### 6. **Toast**

Sistema de notificações snackbar com 4 variantes.

```dart
Toast.show(
  context,
  message: 'Operação realizada com sucesso!',
  variant: ToastVariant.success,
)
```

Variantes: `success`, `error`, `warning`, `info`.

---

### Componentes Úteis

#### 7. **CustomSwitch**

Toggle customizado com label e descrição opcional.

```dart
CustomSwitch(
  value: _enabled,
  onChanged: (value) => setState(() => _enabled = value),
  label: 'Notificações',
  description: 'Receber notificações push',
)
```

#### 8. **CustomAvatar**

Avatar com suporte a imagens, iniciais ou ícones em 3 tamanhos.

```dart
CustomAvatar(
  name: 'Carlos Felipe',
  size: AvatarSize.medium,
)

CustomAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  size: AvatarSize.large,
)
```

Tamanhos: `small` (32px), `medium` (48px), `large` (64px).

#### 9. **Skeleton**

Loading placeholders animados com efeito shimmer.

```dart
Skeleton(height: 16, width: 100)

SkeletonText(lines: 3)

SkeletonCard()
```

#### 10. **CustomDialog**

Modais customizados com tipos alert e confirm.

```dart
CustomDialog.show(
  context: context,
  title: 'Confirmação',
  description: 'Tem certeza?',
  type: DialogType.confirm,
  confirmText: 'Sim',
  cancelText: 'Não',
  onConfirm: () {},
)
```

#### 11. **CustomSheet**

Modal estilo swipe (Bottom Sheet) que desliza de baixo para cima, ideal para menus contextuais ou formulários rápidos.

```dart
CustomSheet.show(
  context: context,
  title: 'Opções',
  description: 'Escolha uma ação abaixo',
  child: MyWidget(),
)
```

---

### Componentes Avançados

#### 12. **CustomCheckbox**

Caixas de seleção com label e descrição.

```dart
CustomCheckbox(
  value: _accepted,
  onChanged: (value) => setState(() => _accepted = value ?? false),
  label: 'Aceitar termos',
  description: 'Li e concordo com os termos',
)
```

#### 13. **CustomRadio & CustomRadioGroup**

Botões de seleção exclusiva gerenciados em grupo.

```dart
CustomRadioGroup<String>(
  value: _selected,
  onChanged: (value) => setState(() => _selected = value),
  items: [
    CustomRadioItem(
      value: 'option1',
      label: 'Opção 1',
      description: 'Descrição da opção',
    ),
    CustomRadioItem(value: 'option2', label: 'Opção 2'),
  ],
)
```

#### 14. **CustomSelect**

Dropdown estilizado com label.

```dart
CustomSelect<String>(
  value: _country,
  label: 'País',
  placeholder: 'Selecione...',
  items: [
    CustomSelectItem(value: 'br', label: 'Brasil'),
    CustomSelectItem(value: 'us', label: 'Estados Unidos'),
  ],
  onChanged: (value) => setState(() => _country = value),
)
```

#### 15. **OTPInput**

Input de código OTP com múltiplos campos, avanço automático de foco e callback ao completar.

```dart
OTPInput(
  label: 'Código OTP',
  helperText: 'Digite o código de 6 dígitos',
  onChanged: (value) => setState(() => _otp = value),
  onCompleted: (value) {
    // código completo
  },
)
```

#### 16. **CustomSlider**

Controle deslizante com valor exibido.

```dart
CustomSlider(
  value: _volume,
  min: 0,
  max: 100,
  divisions: 100,
  label: 'Volume',
  onChanged: (value) => setState(() => _volume = value),
)
```

#### 17. **CustomProgressBar**

Barra de progresso determinada e indeterminada.

```dart
CustomProgressBar(
  value: 0.65,
  label: 'Upload',
  showPercentage: true,
)

CustomProgressBarIndeterminate(
  label: 'Carregando...',
)
```

#### 18. **LoadingSpinner**

Spinner circular para estados de carregamento, com tamanhos e label opcional.

```dart
LoadingSpinner(size: LoadingSpinnerSize.medium)

LoadingSpinner(
  size: LoadingSpinnerSize.large,
  label: 'Carregando...',
)
```

#### 19. **CustomCalendar**

Calendário mensal com navegação entre meses e seleção de data.

```dart
CustomCalendar(
  label: 'Selecione uma data',
  selectedDate: _selectedDate,
  onDateSelected: (date) => setState(() => _selectedDate = date),
)
```

#### 20. **CustomChip**

Tags removíveis e selecionáveis com estilo shadcn/ui.

```dart
CustomChip(
  label: 'Flutter',
  onDeleted: () {},
)

CustomChip(
  label: 'Mobile',
  selected: true,
  onSelected: (selected) {},
)
```

#### 21. **CustomAccordion**

Componente expansível para organizar conteúdo em seções recolhíveis.

```dart
CustomAccordion(
  items: [
    CustomAccordionItem(
      title: 'Pergunta frequente',
      content: Text('Resposta detalhada aqui.'),
    ),
  ],
)
```

#### 22. **CustomTabs**

Sistema de abas com ícones opcionais.

```dart
CustomTabs(
  tabs: [
    CustomTab(label: 'Geral', icon: Icons.home),
    CustomTab(label: 'Configurações', icon: Icons.settings),
  ],
  children: [
    GeralContent(),
    ConfiguracoesContent(),
  ],
)
```

#### 23. **CustomTooltip**

Tooltip customizado com suporte a trigger por toque/clique, seta opcional e alinhamento da seta (`left`, `center`, `right`).

```dart
CustomTooltip(
  message: 'Este é um tooltip',
  arrowAlignment: TooltipArrowAlignment.right,
  child: Icon(Icons.info_outline),
)
```

#### 24. **CustomDataTable**

Tabela de dados poderosa com suporte a ordenação interativa e paginação customizada.

```dart
CustomDataTable<User>(
  items: _pagedUsers,
  totalItems: 100,
  currentPage: 1,
  pageSize: 10,
  onPageChanged: (page) => _fetchPage(page),
  columns: [
    CustomColumn(
      label: 'Nome',
      valueGetter: (user) => user.name,
    ),
    CustomColumn(label: 'Cargo'), // Sem ordenação
  ],
  cellBuilder: (user) => [
    DataCell(Text(user.name)),
    DataCell(CustomBadge(label: user.role)),
  ],
)
```

---

## Componentes de Navegação

#### **CustomBottomNavigationBar**

Uma versão customizada da barra de navegação padrão do Material Design.

- **Familiaridade**: Segue o padrão clássico de navegação inferior.
- **Simplicidade**: Design sólido que utiliza as cores do `scaffoldBackgroundColor`.
- **Auto-ocultação**: Suporte opcional para esconder a barra ao scrollar para baixo e mostrar ao scrollar para cima (`hideOnScroll: true`).
- **Rótulos Opcionais**: Escolha se deseja exibir os nomes dos itens (`showLabels: true`). Quando desativado, a barra assume uma altura reduzida (64px) para um visual mais compacto.

```dart
CustomBottomNavigationBar(
  currentIndex: 0,
  hideOnScroll: true, // Opcional
  showLabels: false,  // Opcional (Padrão: true)
  child: Scaffold(...),
)
```

---

## Visualização dos Componentes

Para ver todos os componentes em ação, acesse a tela de componentes através de:

**Configurações → Componentes**

Esta tela contém exemplos interativos de todos os widgets disponíveis.

---

## Tema

O projeto utiliza cores inspiradas no shadcn/ui com suporte completo a dark mode:

- **Primary**: `#18181B` (light) / `#F4F4F5` (dark)
- **Secondary**: `#F4F4F5` (light) / `#18181B` (dark)
- **Border Radius**: 6px para inputs/buttons, 8px para cards
- **Tipografia**: System font padrão otimizada para mobile

Todos os componentes adaptam automaticamente suas cores baseado no `ThemeMode.system`.

### Customização de Cores

Se desejar alterar as cores do projeto, você pode ajustá-las diretamente no arquivo `lib/theme/theme.dart` dentro da classe `AppColors`.

Por exemplo, para alterar a cor primária para vermelho, você pode ajustar as seguintes constantes:

```dart
class AppColors {
  // Light
  static const primaryLight = Color(0xFFD62828);
  static const onPrimaryLight = Colors.white;
  static const secondaryLight = Color(0xFFFFEBEB);
  static const onSecondaryLight = Color(0xFFD62828);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const scaffoldBackgroundLight = Color(0xFFFFFFFF);

  // Dark
  static const primaryDark = Color(0xFFFF4D4D);
  static const onPrimaryDark = Colors.black;
  static const secondaryDark = Color(0xFF2A1515);
  static const onSecondaryDark = Color(0xFFFFB3B3);
  static const surfaceDark = Color(0xFF121212);
  static const scaffoldBackgroundDark = Color(0xFF0D0D0D);
}
```
