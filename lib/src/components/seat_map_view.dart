import 'package:flutter/material.dart';
import 'package:seatmap/seatmap.dart';
import 'package:seatmap/src/components/compartment_item_widget.dart';

class SeatMapView extends StatelessWidget {
  const SeatMapView({
    super.key,
    required this.isMobile,
    required this.focusKey,
    required this.compartments,
    required this.paxs,
    required this.paxSelected,
    required this.selectSeat,
  });

  final bool isMobile;
  final GlobalKey focusKey;
  final List<Compartment> compartments;
  final List<PaxTicket> paxs;
  final PaxTicket paxSelected;
  final void Function({
    required String compartmentName,
    required String columnItemId,
    required String rowItemId,
    required String column,
    required String row,
  }) selectSeat;

  @override
  Widget build(BuildContext context) {
    if (CompartmentStyle.direction == CompartmentDirection.Vertical) {
      return SizedBox(
        width: CompartmentStyle.width,
        child: Column(
          children: List.generate(compartments.length, (index) {
            return CompartmentItemWidget(
              isMobile: isMobile,
              focusKey: focusKey,
              compartment: compartments[index],
              paxs: paxs,
              paxSelected: paxSelected,
              onTap: selectSeat,
            );
          }),
        ),
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(compartments.length, (index) {
        return SizedBox(
          width: CompartmentStyle.width,
          child: CompartmentItemWidget(
            isMobile: isMobile,
            focusKey: focusKey,
            compartment: compartments[index],
            paxs: paxs,
            paxSelected: paxSelected,
            onTap: selectSeat,
          ),
        );
      }),
    );
  }
}
