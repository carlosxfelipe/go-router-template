import 'package:flutter/material.dart';
import 'package:go_router_template/widgets.dart';

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  // Tags disponíveis para o exemplo de Chips
  static const List<String> _allTags = [
    'Flutter',
    'Dart',
    'Mobile',
    'Web',
    'Desktop',
    'Backend',
  ];

  // Controllers de formulário e estado de componentes básicos
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _emailError;
  bool _obscurePassword = true;
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _isLoading = false;

  // Estado de componentes avançados
  bool _termsAccepted = false;
  bool _newsletterSubscribed = false;
  String? _selectedPayment = 'credit';
  String? _selectedCountry;
  String _otpCode = '';
  DateTime? _selectedDate;
  double _volumeValue = 50;
  double _progressValue = 0.65;
  final List<String> _selectedTags = ['Flutter', 'Dart'];

  // Dados mockados para o exemplo de DataTable
  final List<Map<String, String>> _users = [
    {
      'id': '1',
      'nome': 'Carlos Felipe',
      'email': 'carlos@example.com',
      'cargo': 'Dev',
    },
    {
      'id': '2',
      'nome': 'João Silva',
      'email': 'joao@example.com',
      'cargo': 'Designer',
    },
    {
      'id': '3',
      'nome': 'Maria Santos',
      'email': 'maria@example.com',
      'cargo': 'PM',
    },
    {
      'id': '4',
      'nome': 'Ana Oliveira',
      'email': 'ana@example.com',
      'cargo': 'Dev',
    },
    {
      'id': '5',
      'nome': 'Pedro Lima',
      'email': 'pedro@example.com',
      'cargo': 'Designer',
    },
    {
      'id': '6',
      'nome': 'Julia Costa',
      'email': 'julia@example.com',
      'cargo': 'PM',
    },
    {
      'id': '7',
      'nome': 'Marcos Souza',
      'email': 'marcos@example.com',
      'cargo': 'Dev Ops',
    },
    {
      'id': '8',
      'nome': 'Beatriz Rocha',
      'email': 'beatriz@example.com',
      'cargo': 'QA',
    },
  ];

  // Estado da paginação para o exemplo de DataTable
  int _currentPage = 1;
  static const int _pageSize = 3;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = null;
      } else if (!value.contains('@')) {
        _emailError = 'Email inválido';
      } else {
        _emailError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Componentes'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Inputs
            _SectionTitle(title: 'Inputs'),
            const SizedBox(height: 12),
            Input(
              controller: _nameController,
              label: 'Nome',
              placeholder: 'Digite seu nome',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            Input(
              controller: _emailController,
              label: 'Email',
              placeholder: 'exemplo@email.com',
              prefixIcon: Icons.email,
              helperText: 'Seu email será mantido em sigilo',
              errorText: _emailError,
              onChanged: _validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Input(
              controller: _dateController,
              label: 'Data de Nascimento',
              placeholder: 'Selecione uma data',
              prefixIcon: Icons.calendar_today,
              readOnly: true,
              onTap: () {
                CustomSheet.show(
                  context: context,
                  title: 'Selecionar Data',
                  description: 'Escolha uma data no calendário abaixo.',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomCalendar(
                      selectedDate: _selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                          _dateController.text =
                              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                        });
                        Navigator.pop(context); // Fecha o sheet após selecionar
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Input(
              label: 'Senha',
              placeholder: 'Digite sua senha',
              prefixIcon: Icons.lock,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            const SizedBox(height: 16),
            Input(
              label: 'Mensagem',
              placeholder: 'Digite sua mensagem...',
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            OTPInput(
              label: 'Código OTP',
              helperText: 'Digite o código de 6 dígitos',
              onChanged: (value) {
                setState(() => _otpCode = value);
              },
              onCompleted: (value) {
                Toast.show(
                  context,
                  message: 'Código completo: $value',
                  variant: ToastVariant.success,
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              'OTP atual: ${_otpCode.isEmpty ? '-' : _otpCode}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Buttons
            _SectionTitle(title: 'Botões'),
            const SizedBox(height: 12),
            Button(
              label: 'Botão Primário',
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Botão primário clicado!',
                  variant: ToastVariant.success,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Com Ícone',
              icon: Icons.send,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Mensagem enviada!',
                  variant: ToastVariant.info,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Botão Outlined',
              outlined: true,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Botão outlined clicado!',
                  variant: ToastVariant.warning,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(label: 'Botão Desabilitado', onPressed: null),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Badges
            _SectionTitle(title: 'Badges'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CustomBadge(label: 'Default', variant: BadgeVariant.default_),
                CustomBadge(
                  label: 'Secondary',
                  variant: BadgeVariant.secondary,
                ),
                CustomBadge(label: 'Success', variant: BadgeVariant.success),
                CustomBadge(label: 'Warning', variant: BadgeVariant.warning),
                CustomBadge(label: 'Error', variant: BadgeVariant.error),
                CustomBadge(label: 'Info', variant: BadgeVariant.info),
              ],
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Cards
            _SectionTitle(title: 'Cards'),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Card Simples',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CustomBadge(
                        label: 'Novo',
                        variant: BadgeVariant.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Este é um card com borda e padding customizável. Perfeito para agrupar conteúdo relacionado.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomCard(
              onTap: () {
                Toast.show(
                  context,
                  message: 'Card clicável foi pressionado!',
                  variant: ToastVariant.success,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    color: theme.colorScheme.onSurface,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Interativo',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Toque para interagir',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(153),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.colorScheme.onSurface.withAlpha(153),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Toasts
            _SectionTitle(title: 'Toasts'),
            const SizedBox(height: 12),
            Button(
              label: 'Mostrar Toast de Sucesso',
              icon: Icons.check_circle,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Operação realizada com sucesso!',
                  variant: ToastVariant.success,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Mostrar Toast de Erro',
              icon: Icons.error,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Ocorreu um erro ao processar a solicitação.',
                  variant: ToastVariant.error,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Mostrar Toast de Aviso',
              icon: Icons.warning,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Atenção! Verifique os dados inseridos.',
                  variant: ToastVariant.warning,
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Mostrar Toast de Info',
              icon: Icons.info,
              onPressed: () {
                Toast.show(
                  context,
                  message: 'Esta é uma mensagem informativa.',
                  variant: ToastVariant.info,
                );
              },
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Tooltip
            _SectionTitle(title: 'Tooltip'),
            const SizedBox(height: 12),
            CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Toque/clique ou passe o mouse no ícone',
                    style: theme.textTheme.bodyMedium,
                  ),
                  CustomTooltip(
                    message: 'Este é um tooltip customizado',
                    arrowAlignment: TooltipArrowAlignment.centerRight,
                    child: Icon(
                      Icons.info_outline,
                      size: 22,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Switches
            _SectionTitle(title: 'Switches'),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                children: [
                  CustomSwitch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                    label: 'Notificações',
                    description: 'Receber notificações push no dispositivo',
                  ),
                  const SizedBox(height: 8),
                  const Separator(),
                  const SizedBox(height: 8),
                  CustomSwitch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() => _darkModeEnabled = value);
                    },
                    label: 'Modo Escuro',
                    description: 'Ativar tema escuro automaticamente',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Avatars
            _SectionTitle(title: 'Avatars'),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CustomAvatar(name: 'Carlos Felipe', size: AvatarSize.small),
                    SizedBox(height: 8),
                    Text('Small', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CustomAvatar(name: 'João Silva', size: AvatarSize.medium),
                    SizedBox(height: 8),
                    Text('Medium', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CustomAvatar(name: 'Maria Santos', size: AvatarSize.large),
                    SizedBox(height: 8),
                    Text('Large', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAvatar(icon: Icons.person, size: AvatarSize.medium),
                CustomAvatar(icon: Icons.settings, size: AvatarSize.medium),
                CustomAvatar(icon: Icons.favorite, size: AvatarSize.medium),
              ],
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Skeleton
            _SectionTitle(title: 'Skeleton Loading'),
            const SizedBox(height: 12),
            Button(
              label: _isLoading ? 'Ocultar Skeleton' : 'Mostrar Skeleton',
              icon: Icons.hourglass_empty,
              onPressed: () {
                setState(() => _isLoading = !_isLoading);
              },
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              CustomCard(child: const SkeletonCard())
            else
              CustomCard(
                child: Row(
                  children: [
                    const CustomAvatar(
                      name: 'Carlos Felipe Araújo',
                      size: AvatarSize.large,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carlos Felipe Araújo',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Desenvolvedor Flutter',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withAlpha(153),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Apaixonado por criar experiências incríveis em aplicativos móveis com Flutter e Dart.',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Dialogs
            _SectionTitle(title: 'Dialogs'),
            const SizedBox(height: 12),
            Button(
              label: 'Alert Dialog',
              icon: Icons.info,
              onPressed: () {
                CustomDialog.show(
                  context: context,
                  title: 'Informação',
                  description: 'Este é um dialog de alerta simples.',
                  type: DialogType.alert,
                  onConfirm: () {
                    Toast.show(
                      context,
                      message: 'Dialog fechado',
                      variant: ToastVariant.info,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Confirm Dialog',
              icon: Icons.help,
              onPressed: () {
                CustomDialog.show(
                  context: context,
                  title: 'Confirmação',
                  description:
                      'Tem certeza que deseja continuar com esta ação?',
                  type: DialogType.confirm,
                  confirmText: 'Sim',
                  cancelText: 'Não',
                  onConfirm: () {
                    Toast.show(
                      context,
                      message: 'Ação confirmada!',
                      variant: ToastVariant.success,
                    );
                  },
                  onCancel: () {
                    Toast.show(
                      context,
                      message: 'Ação cancelada',
                      variant: ToastVariant.warning,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            Button(
              label: 'Swipe Modal (Sheet)',
              icon: Icons.unfold_more,
              onPressed: () {
                CustomSheet.show(
                  context: context,
                  title: 'Swipe Modal',
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  description:
                      'Este é um componente que desliza de baixo para cima e pode ser fechado com um gesto.',
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Editar Perfil'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Configurações'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Checkboxes
            _SectionTitle(title: 'Checkboxes'),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                children: [
                  CustomCheckbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() => _termsAccepted = value ?? false);
                    },
                    label: 'Aceitar termos e condições',
                    description: 'Li e concordo com os termos de uso',
                  ),
                  const SizedBox(height: 8),
                  const Separator(),
                  const SizedBox(height: 8),
                  CustomCheckbox(
                    value: _newsletterSubscribed,
                    onChanged: (value) {
                      setState(() => _newsletterSubscribed = value ?? false);
                    },
                    label: 'Receber newsletter',
                    description: 'Receber novidades e promoções por email',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Radio Buttons
            _SectionTitle(title: 'Radio Buttons'),
            const SizedBox(height: 12),
            CustomCard(
              child: CustomRadioGroup<String>(
                value: _selectedPayment,
                onChanged: (value) {
                  setState(() => _selectedPayment = value);
                },
                items: const [
                  CustomRadioItem(
                    value: 'credit',
                    label: 'Cartão de Crédito',
                    description: 'Pagamento parcelado em até 12x',
                  ),
                  CustomRadioItem(
                    value: 'debit',
                    label: 'Cartão de Débito',
                    description: 'Pagamento à vista com desconto',
                  ),
                  CustomRadioItem(
                    value: 'pix',
                    label: 'PIX',
                    description: 'Transferência instantânea',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Select
            _SectionTitle(title: 'Select / Dropdown'),
            const SizedBox(height: 12),
            CustomSelect<String>(
              value: _selectedCountry,
              label: 'País',
              placeholder: 'Selecione seu país',
              items: const [
                CustomSelectItem(value: 'br', label: 'Brasil'),
                CustomSelectItem(value: 'us', label: 'Estados Unidos'),
                CustomSelectItem(value: 'pt', label: 'Portugal'),
                CustomSelectItem(value: 'ar', label: 'Argentina'),
                CustomSelectItem(value: 'mx', label: 'México'),
              ],
              onChanged: (value) {
                setState(() => _selectedCountry = value);
              },
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Calendar
            _SectionTitle(title: 'Calendar'),
            const SizedBox(height: 12),
            CustomCalendar(
              label: 'Selecione uma data',
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
              },
            ),
            if (_selectedDate != null) ...[
              const SizedBox(height: 12),
              Text(
                'Data selecionada: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                style: theme.textTheme.bodyMedium,
              ),
            ],

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Accordion
            _SectionTitle(title: 'Accordion'),
            const SizedBox(height: 12),
            CustomAccordion(
              items: [
                CustomAccordionItem(
                  title: 'O que é este template?',
                  content: Text(
                    'Um template Flutter com componentes reutilizáveis e estrutura pronta para acelerar desenvolvimento.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomAccordionItem(
                  title: 'Tem suporte a tema escuro?',
                  content: Text(
                    'Sim. Os componentes respeitam o tema atual e se adaptam automaticamente ao modo claro/escuro.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomAccordionItem(
                  title: 'Posso expandir múltiplos itens?',
                  content: Text(
                    'Pode. Basta configurar allowMultipleExpanded como true no CustomAccordion.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Tabs
            _SectionTitle(title: 'Tabs'),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: CustomTabs(
                tabs: const [
                  CustomTab(label: 'Início', icon: Icons.home),
                  CustomTab(label: 'Perfil', icon: Icons.person),
                  CustomTab(label: 'Apenas Texto'),
                ],
                children: [
                  const Center(child: Text('Conteúdo da Aba de Início')),
                  const Center(child: Text('Configurações de Perfil')),
                  const Center(
                    child: Text('Aba sem ícones para um visual limpo'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Slider
            _SectionTitle(title: 'Slider'),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                children: [
                  CustomSlider(
                    value: _volumeValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: 'Volume',
                    onChanged: (value) {
                      setState(() => _volumeValue = value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Progress Bar
            _SectionTitle(title: 'Progress Bar'),
            const SizedBox(height: 12),
            CustomProgressBar(
              value: _progressValue,
              label: 'Upload de arquivo',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Diminuir',
                    outlined: true,
                    onPressed: () {
                      setState(() {
                        _progressValue = (_progressValue - 0.1).clamp(0.0, 1.0);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Button(
                    label: 'Aumentar',
                    onPressed: () {
                      setState(() {
                        _progressValue = (_progressValue + 0.1).clamp(0.0, 1.0);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CustomProgressBarIndeterminate(label: 'Carregando dados...'),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Loading Spinner
            _SectionTitle(title: 'Loading Spinner'),
            const SizedBox(height: 12),
            const CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoadingSpinner(size: LoadingSpinnerSize.small),
                  LoadingSpinner(size: LoadingSpinnerSize.medium),
                  LoadingSpinner(size: LoadingSpinnerSize.large),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const LoadingSpinner(label: 'Carregando...'),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Chips
            _SectionTitle(title: 'Chips'),
            const SizedBox(height: 12),
            Text(
              'Tags Selecionadas',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedTags
                  .map(
                    (tag) => CustomChip(
                      label: tag,
                      onDeleted: () {
                        setState(() => _selectedTags.remove(tag));
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Adicionar Tags',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allTags
                  .where((tag) => !_selectedTags.contains(tag))
                  .map(
                    (tag) => CustomChip(
                      label: tag,
                      selected: false,
                      onSelected: (selected) {
                        if (selected && !_selectedTags.contains(tag)) {
                          setState(() => _selectedTags.add(tag));
                        }
                      },
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 32),
            const Separator(),
            const SizedBox(height: 32),

            // Section: Data Table
            _SectionTitle(title: 'Data Table'),
            const SizedBox(height: 12),
            CustomCard(
              padding: EdgeInsets.zero,
              child: CustomDataTable<Map<String, String>>(
                // Simulamos o backend: mandamos apenas a "fatia" da página atual
                items: _users
                    .skip((_currentPage - 1) * _pageSize)
                    .take(_pageSize)
                    .toList(),
                currentPage: _currentPage,
                pageSize: _pageSize,
                totalItems: _users.length,
                onPageChanged: (newPage) {
                  setState(() => _currentPage = newPage);
                },
                columns: [
                  CustomColumn(label: 'ID', valueGetter: (user) => user['id']!),
                  CustomColumn(
                    label: 'Nome',
                    valueGetter: (user) => user['nome']!,
                  ),
                  CustomColumn(
                    label: 'Email',
                    valueGetter: (user) => user['email']!,
                  ),
                  CustomColumn(
                    label: 'Cargo',
                    valueGetter: (user) => user['cargo']!,
                  ),
                ],
                cellBuilder: (user) => [
                  DataCell(Text(user['id']!)),
                  DataCell(Text(user['nome']!)),
                  DataCell(Text(user['email']!)),
                  DataCell(
                    CustomBadge(
                      label: user['cargo']!,
                      variant: BadgeVariant.secondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
