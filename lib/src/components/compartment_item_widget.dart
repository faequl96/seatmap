import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seatmap/seatmap.dart';
import 'package:seatmap/src/components/column_item_widget.dart';

class CompartmentItemWidget extends StatefulWidget {
  const CompartmentItemWidget({
    super.key,
    required this.isMobile,
    required this.focusKey,
    required this.compartment,
    required this.paxs,
    required this.paxSelected,
    required this.onTap,
  });

  final bool isMobile;
  final GlobalKey focusKey;
  final Compartment compartment;
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
  State<CompartmentItemWidget> createState() => _CompartmentItemWidgetState();
}

class _CompartmentItemWidgetState extends State<CompartmentItemWidget> {
  void _takeScreenShoot() {}

  @override
  Widget build(BuildContext context) {
    final compartment = widget.compartment;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade100, Colors.orange.shade100],
                ),
              ),
              child: Center(
                child: Text(
                  widget.compartment.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(compartment.columnItems.length, (index) {
              return ColumnItemWidget(
                focusKey: widget.focusKey,
                columnItem: compartment.columnItems[index],
                compartmentName: compartment.name,
                paxs: widget.paxs,
                paxSelected: widget.paxSelected,
                onTap: widget.onTap,
              );
            }),
            const SizedBox(height: 12),
          ],
        ),
        if (!kIsWeb)
          Positioned(
            top: 10,
            right: 24,
            child: TakeScreenShotButton(
              isMobile: widget.isMobile,
              takeScreenShoot: _takeScreenShoot,
            ),
          ),
        if (kIsWasm)
          Positioned(
            top: 10,
            right: 24,
            child: TakeScreenShotButton(
              isMobile: widget.isMobile,
              takeScreenShoot: _takeScreenShoot,
            ),
          ),
      ],
    );
  }
}

class TakeScreenShotButton extends StatelessWidget {
  const TakeScreenShotButton({
    super.key,
    required this.isMobile,
    required this.takeScreenShoot,
  });

  final bool isMobile;
  final void Function() takeScreenShoot;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
