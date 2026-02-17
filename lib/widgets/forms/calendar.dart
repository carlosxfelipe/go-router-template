import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    super.key,
    this.initialDate,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.onDateSelected,
  });

  final DateTime? initialDate;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final ValueChanged<DateTime>? onDateSelected;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  static const List<String> _monthNames = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  static const List<String> _weekdays = [
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb',
    'Dom',
  ];

  late DateTime _displayedMonth;
  DateTime? _selectedDate;

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    final safeInitialDate = widget.initialDate ?? widget.selectedDate ?? _today;
    _displayedMonth = DateTime(safeInitialDate.year, safeInitialDate.month);
    _selectedDate = _normalizeDate(widget.selectedDate);
  }

  DateTime _normalizeDate(DateTime? date) {
    if (date == null) {
      return _today;
    }
    return DateTime(date.year, date.month, date.day);
  }

  DateTime? _normalizeNullableDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isInRange(DateTime date) {
    final firstDate = _normalizeNullableDate(widget.firstDate);
    final lastDate = _normalizeNullableDate(widget.lastDate);
    if (firstDate != null && date.isBefore(firstDate)) {
      return false;
    }
    if (lastDate != null && date.isAfter(lastDate)) {
      return false;
    }
    return true;
  }

  void _changeMonth(int delta) {
    final candidate = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + delta,
    );
    final firstDate = _normalizeNullableDate(widget.firstDate);
    final lastDate = _normalizeNullableDate(widget.lastDate);

    if (firstDate != null) {
      final firstMonth = DateTime(firstDate.year, firstDate.month);
      if (candidate.isBefore(firstMonth)) {
        return;
      }
    }

    if (lastDate != null) {
      final lastMonth = DateTime(lastDate.year, lastDate.month);
      if (candidate.isAfter(lastMonth)) {
        return;
      }
    }

    setState(() {
      _displayedMonth = candidate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final firstDayOfMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    );
    final daysInMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + 1,
      0,
    ).day;
    final leadingEmptyDays = firstDayOfMonth.weekday - 1;

    final totalCells = (leadingEmptyDays + daysInMonth <= 35) ? 35 : 42;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _changeMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                    visualDensity: VisualDensity.compact,
                  ),
                  Text(
                    '${_monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeMonth(1),
                    icon: const Icon(Icons.chevron_right),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      _weekdays[index],
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: totalCells,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final day = index - leadingEmptyDays + 1;
                  if (day < 1 || day > daysInMonth) {
                    return const SizedBox.shrink();
                  }

                  final cellDate = DateTime(
                    _displayedMonth.year,
                    _displayedMonth.month,
                    day,
                  );
                  final isSelected =
                      _selectedDate != null &&
                      _isSameDay(_selectedDate!, cellDate);
                  final isToday = _isSameDay(cellDate, _today);
                  final isEnabled = _isInRange(cellDate);

                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      onTap: isEnabled
                          ? () {
                              setState(() {
                                _selectedDate = cellDate;
                              });
                              widget.onDateSelected?.call(cellDate);
                            }
                          : null,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: isToday && !isSelected
                              ? Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: !isEnabled
                                  ? theme.colorScheme.onSurface.withAlpha(90)
                                  : (isSelected
                                        ? theme.colorScheme.onPrimary
                                        : theme.colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
