import 'package:flutter/material.dart';

/// Define uma coluna para a CustomDataTable.
class CustomColumn<T> {
  final String label;

  /// Extrai o valor para permitir a ordenação desta coluna.
  final Comparable Function(T item)? valueGetter;

  final bool numeric;

  CustomColumn({required this.label, this.valueGetter, this.numeric = false});
}

class CustomDataTable<T> extends StatefulWidget {
  const CustomDataTable({
    super.key,
    required this.items,
    required this.columns,
    required this.cellBuilder,
    this.headingRowHeight = 48,
    this.dataRowMaxHeight = 64,
    this.columnSpacing = 24,
    // Novos campos para paginação
    this.currentPage,
    this.pageSize,
    this.totalItems,
    this.onPageChanged,
  });

  final List<T> items;
  final List<CustomColumn<T>> columns;
  final List<DataCell> Function(T item) cellBuilder;
  final double headingRowHeight;
  final double dataRowMaxHeight;
  final double columnSpacing;

  // Paginação
  final int? currentPage;
  final int? pageSize;
  final int? totalItems;
  final ValueChanged<int>? onPageChanged;

  @override
  State<CustomDataTable<T>> createState() => _CustomDataTableState<T>();
}

class _CustomDataTableState<T> extends State<CustomDataTable<T>> {
  late List<T> _displayItems;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _displayItems = List.from(widget.items);
  }

  @override
  void didUpdateWidget(CustomDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _displayItems = List.from(widget.items);
      // Mantém a ordenação atual se uma coluna estiver selecionada
      if (_sortColumnIndex != null) {
        _applySort();
      }
    }
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _applySort();
    });
  }

  void _applySort() {
    if (_sortColumnIndex == null) return;

    final column = widget.columns[_sortColumnIndex!];
    final getter = column.valueGetter;

    if (getter != null) {
      _displayItems.sort((a, b) {
        final valueA = getter(a);
        final valueB = getter(b);
        return _sortAscending
            ? Comparable.compare(valueA, valueB)
            : Comparable.compare(valueB, valueA);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Lógica boba para saber se tem paginação
    final hasPagination =
        widget.currentPage != null &&
        widget.pageSize != null &&
        widget.totalItems != null &&
        widget.onPageChanged != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  headingRowHeight: widget.headingRowHeight,
                  headingRowColor: WidgetStateProperty.all(
                    theme.colorScheme.secondary,
                  ),
                  dataRowMaxHeight: widget.dataRowMaxHeight,
                  columnSpacing: widget.columnSpacing,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  headingTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                  columns: List.generate(widget.columns.length, (index) {
                    final column = widget.columns[index];
                    return DataColumn(
                      label: Text(column.label),
                      numeric: column.numeric,
                      onSort: column.valueGetter != null ? _onSort : null,
                    );
                  }),
                  rows: _displayItems.map((item) {
                    return DataRow(cells: widget.cellBuilder(item));
                  }).toList(),
                ),
              ),
            );
          },
        ),
        if (hasPagination) ...[
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${widget.totalItems} itens',
                  style: theme.textTheme.bodySmall,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: widget.currentPage! > 1
                          ? () => widget.onPageChanged!(widget.currentPage! - 1)
                          : null,
                    ),
                    Text(
                      'Página ${widget.currentPage}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed:
                          (widget.currentPage! * widget.pageSize!) <
                              widget.totalItems!
                          ? () => widget.onPageChanged!(widget.currentPage! + 1)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
