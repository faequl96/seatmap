import 'package:flutter/material.dart';
import 'package:seatmap/seatmap.dart';

class SeatMapIndicatorWidget extends StatefulWidget {
  const SeatMapIndicatorWidget({super.key});

  @override
  State<SeatMapIndicatorWidget> createState() => _SeatMapIndicatorWidgetState();
}

class _SeatMapIndicatorWidgetState extends State<SeatMapIndicatorWidget> {
  final _key = GlobalKey();
  double _modalWidth = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _modalWidth = _key.currentContext?.size?.width ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -4),
            blurRadius: 3,
            color: Colors.black12,
          )
        ],
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(
        children: [
          if (_modalWidth <= 740) ...[
            const Row(
              children: [
                _SeatMapIndicator(indicator: Indicator.Booked),
                _SeatMapIndicator(indicator: Indicator.Available),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                _SeatMapIndicator(indicator: Indicator.YourChoice),
                _SeatMapIndicator(indicator: Indicator.YourPrevBook),
              ],
            ),
          ] else
            const Row(
              children: [
                _SeatMapIndicator(indicator: Indicator.Booked),
                _SeatMapIndicator(indicator: Indicator.Available),
                _SeatMapIndicator(indicator: Indicator.YourChoice),
                _SeatMapIndicator(indicator: Indicator.YourPrevBook),
              ],
            ),
        ],
      ),
    );
  }
}

class _SeatMapIndicator extends StatelessWidget {
  const _SeatMapIndicator({required this.indicator});

  final Indicator indicator;

  @override
  Widget build(BuildContext context) {
    final title = {
      Indicator.Booked: "Booked",
      Indicator.Available: "Available",
      Indicator.YourChoice: "Your Choice",
      Indicator.YourPrevBook: "Your Previous Book",
    };

    return Expanded(
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Constants.borderColors[indicator]!,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Constants.colors[indicator]!,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title[indicator]!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
