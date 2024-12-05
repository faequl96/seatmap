import 'package:flutter/material.dart';
import 'package:seatmap/seatmap.dart';
import 'package:seatmap/src/components/row_item_widget.dart';

class ColumnItemWidget extends StatelessWidget {
  const ColumnItemWidget({
    super.key,
    required this.focusKey,
    required this.columnItem,
    required this.compartmentName,
    required this.paxs,
    required this.paxSelected,
    required this.onTap,
  });

  final GlobalKey focusKey;
  final ColumnItem columnItem;
  final String compartmentName;
  final List<PaxTicket> paxs;
  final PaxTicket paxSelected;
  final void Function({
    required String compartmentName,
    required String columnItemId,
    required String rowItemId,
    required String column,
    required String row,
  }) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(columnItem.rowItems.length, (index) {
        return RowItemWidget(
          key: Key("row_item_widget_${index}_col_id=${columnItem.id}"),
          focusKey: focusKey,
          rowItem: columnItem.rowItems[index],
          compartmentName: compartmentName,
          columnItemId: columnItem.id,
          paxs: paxs,
          paxSelected: paxSelected,
          onTap: onTap,
        );
      }),
    );
  }
}
