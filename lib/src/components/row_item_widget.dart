import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seatmap/seatmap.dart';

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({
    super.key,
    required this.focusKey,
    required this.rowItem,
    required this.compartmentName,
    required this.columnItemId,
    required this.paxs,
    required this.paxSelected,
    required this.onTap,
  });

  final GlobalKey focusKey;
  final RowItem rowItem;
  final String compartmentName;
  final String columnItemId;
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
    bool isCurrentSelected = false;
    bool isCurrentSelectedPrev = false;
    String paxName = "";
    String paxNamePrev = "";

    for (int i = 0; i < paxs.length; i++) {
      if (rowItem.id == paxs[i].seatId) {
        isCurrentSelected = true;
        paxName = paxs[i].paxName;
      }
    }

    for (int i = 0; i < SeatMapData.previousPaxs.length; i++) {
      if (rowItem.id == SeatMapData.previousPaxs[i].seatId) {
        isCurrentSelectedPrev = true;
        paxNamePrev = "${SeatMapData.previousPaxs[i].paxName} (Previous)";
      }
    }

    switch (rowItem.type) {
      case RowItemType.Seat:
        return Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: MouseRegion(
              cursor: rowItem.status == RowItemStatus.Available
                  ? SystemMouseCursors.click
                  : MouseCursor.defer,
              child: GestureDetector(
                onTap: rowItem.status == RowItemStatus.Available
                    ? () => onTap(
                          compartmentName: compartmentName,
                          columnItemId: columnItemId,
                          rowItemId: rowItem.id,
                          column: rowItem.column,
                          row: rowItem.row,
                        )
                    : null,
                child: isCurrentSelected || isCurrentSelectedPrev
                    ? isCurrentSelected
                        ? Tooltip(
                            message: paxName,
                            verticalOffset: 10,
                            child: rowItem.id == paxSelected.seatId
                                ? _FlashesSeat(key: focusKey, rowItem: rowItem)
                                : _Seat(
                                    rowItem: rowItem,
                                    indicator: Indicator.YourChoice,
                                  ),
                          )
                        : Tooltip(
                            message: paxNamePrev,
                            verticalOffset: 10,
                            child: _Seat(
                              rowItem: rowItem,
                              indicator: Indicator.YourPrevBook,
                            ),
                          )
                    : rowItem.status == RowItemStatus.Booked
                        ? _Seat(rowItem: rowItem, indicator: Indicator.Booked)
                        : _Seat(
                            rowItem: rowItem,
                            indicator: Indicator.Available,
                          ),
              ),
            ),
          ),
        );
      case RowItemType.Undifined:
        return const Spacer(flex: 3);
      case RowItemType.Aisle:
        return const Spacer(flex: 2);
    }
  }
}

class _Seat extends StatelessWidget {
  const _Seat({required this.rowItem, required this.indicator});

  final RowItem rowItem;
  final Indicator indicator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Constants.borderColors[indicator]!),
        borderRadius: BorderRadius.circular(8),
        color: Constants.colors[indicator]!,
      ),
      child: Center(
        child: Text(
          "${rowItem.row}${rowItem.column}",
          style: TextStyle(
            color: indicator == Indicator.Available
                ? Colors.grey.shade800
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _FlashesSeat extends StatefulWidget {
  const _FlashesSeat({super.key, required this.rowItem});

  final RowItem rowItem;

  @override
  State<_FlashesSeat> createState() => _FlashesSeatState();
}

class _FlashesSeatState extends State<_FlashesSeat> {
  bool isLight = false;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() => isLight = !isLight);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: isLight ? Colors.green.shade200 : Colors.green.shade900,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      ),
      child: Center(
        child: Text(
          "${widget.rowItem.row}${widget.rowItem.column}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
