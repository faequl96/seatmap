import 'package:flutter/material.dart';
import 'package:seatmap/src/components/seat_map_view.dart';
import 'package:seatmap/src/components/seatmap_indicator_widget.dart';

part 'constants/constants.dart';
part 'data/seatmap_data.dart';
part 'enums/enums.dart';
part 'models/models.dart';
part 'styles/compartment_style.dart';

class SeatMapWidget extends StatefulWidget {
  const SeatMapWidget({
    super.key,
    required this.isMobile,
    required this.compartments,
    required this.paxs,
    required this.paxSelected,
    required this.onChange,
  });

  final bool isMobile;
  final List<Compartment> compartments;
  final List<PaxTicket> paxs;
  final PaxTicket paxSelected;
  final void Function(List<PaxTicket> paxs) onChange;

  @override
  State<SeatMapWidget> createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  final _focusKey = GlobalKey();

  void _selectSeat({
    required String compartmentName,
    required String columnItemId,
    required String rowItemId,
    required String column,
    required String row,
  }) {
    int paxRemovedIndex = 0;
    List<PaxTicket> paxs = [];

    for (final item in widget.paxs) {
      paxs.add(PaxTicket(
        paxIdNumber: item.paxIdNumber,
        paxName: item.paxName,
        ticketNo: item.ticketNo,
        compartmentId: item.compartmentId,
        seatId: item.seatId,
        seatNo: item.seatNo,
        column: item.column,
        row: item.row,
      ));
    }

    // Untuk menghapus sementara paxTicket yang terpilih untuk kemudian diganti dengan data paxTicket yang baru.
    for (int i = 0; i < widget.paxs.length; i++) {
      if (widget.paxs[i].paxIdNumber == widget.paxSelected.paxIdNumber) {
        paxRemovedIndex = i;
        paxs.removeAt(i);
      }
    }

    final comparts = widget.compartments;
    for (int i = 0; i < comparts.length; i++) {
      if (comparts[i].name == compartmentName) {
        for (int j = 0; j < comparts[i].columnItems.length; j++) {
          if (comparts[i].columnItems[j].id == columnItemId) {
            final rowItems = comparts[i].columnItems[j].rowItems;
            for (int k = 0; k < rowItems.length; k++) {
              // Untuk menghapus kursi pilihan sebelumnya menjadi status availabe.
              if (rowItems[k].id == widget.paxSelected.seatId) {
                final rowItem = comparts[i].columnItems[j].rowItems[k];
                comparts[i].columnItems[j].rowItems[k] = RowItem(
                  id: rowItem.id,
                  row: rowItem.row,
                  column: rowItem.column,
                  type: rowItem.type,
                  status: RowItemStatus.Available,
                );
              }
              // Untuk menetapkan kursi yang baru dipilih menjadi status booked.
              if (rowItems[k].id == rowItemId) {
                final rowItem = comparts[i].columnItems[j].rowItems[k];
                comparts[i].columnItems[j].rowItems[k] = RowItem(
                  id: rowItem.id,
                  row: rowItem.row,
                  column: rowItem.column,
                  type: rowItem.type,
                  status: RowItemStatus.Booked,
                );

                // Untuk mengganti paxTicket yang telah dihapus sebelumnya dengan data paxTicket yang baru.
                paxs.insert(
                  paxRemovedIndex,
                  PaxTicket(
                    paxIdNumber: widget.paxSelected.paxIdNumber,
                    paxName: widget.paxSelected.paxName,
                    ticketNo: widget.paxSelected.ticketNo,
                    compartmentId: compartmentName,
                    seatId: rowItemId,
                    seatNo: widget.paxSelected.seatNo,
                    column: column,
                    row: row,
                  ),
                );
              }
            }
          } else {
            final rowItems = comparts[i].columnItems[j].rowItems;
            for (int k = 0; k < rowItems.length; k++) {
              if (rowItems[k].id == widget.paxSelected.seatId) {
                final rowItem = comparts[i].columnItems[j].rowItems[k];
                comparts[i].columnItems[j].rowItems[k] = RowItem(
                  id: rowItem.id,
                  row: rowItem.row,
                  column: rowItem.column,
                  type: rowItem.type,
                  status: RowItemStatus.Available,
                );
              }
            }
          }
        }
      } else {
        for (int j = 0; j < comparts[i].columnItems.length; j++) {
          final rowItems = comparts[i].columnItems[j].rowItems;
          for (int k = 0; k < rowItems.length; k++) {
            if (rowItems[k].id == widget.paxSelected.seatId) {
              final rowItem = comparts[i].columnItems[j].rowItems[k];
              comparts[i].columnItems[j].rowItems[k] = RowItem(
                id: rowItem.id,
                row: rowItem.row,
                column: rowItem.column,
                type: rowItem.type,
                status: RowItemStatus.Available,
              );
            }
          }
        }
      }
    }
    setState(() {});
    widget.onChange(paxs);
  }

  void _setFocus() async {
    await Future.delayed(const Duration(milliseconds: 320));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        _focusKey.currentContext ?? context,
        alignment: 0.5,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  void initState() {
    _setFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _LoadingProgress(),
        Expanded(
          child: _Content(
            seatMapView: SeatMapView(
              isMobile: widget.isMobile,
              focusKey: _focusKey,
              compartments: widget.compartments,
              paxs: widget.paxs,
              paxSelected: widget.paxSelected,
              selectSeat: _selectSeat,
            ),
          ),
        ),
        const SeatMapIndicatorWidget(),
      ],
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({required this.seatMapView});

  final SeatMapView seatMapView;

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  bool _isCompleted = false;

  void _setup() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _isCompleted = true);
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCompleted) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: widget.seatMapView,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _LoadingProgress extends StatefulWidget {
  const _LoadingProgress();

  @override
  State<_LoadingProgress> createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<_LoadingProgress> {
  bool _isCompleted = false;

  void _setup() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _isCompleted = true);
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCompleted) return const SizedBox.shrink();

    return const SizedBox(
      height: 6,
      width: double.maxFinite,
      child: LinearProgressIndicator(),
    );
  }
}
