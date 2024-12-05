part of '../seat_map_widget.dart';

class CompartmentStyle {
  CompartmentStyle._();

  static CompartmentDirection direction = CompartmentDirection.Vertical;
  static double? width;
  static bool interactiveViewer = false;

  static void directionToVertical() =>
      direction = CompartmentDirection.Vertical;
  static void directionToWrap({double compartmentWidth = 400}) {
    width = compartmentWidth;
    direction = CompartmentDirection.Wrap;
  }
}
