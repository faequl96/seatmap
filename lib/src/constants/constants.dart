part of '../seat_map_widget.dart';

class Constants {
  Constants._();

  static final colors = {
    Indicator.Booked: Colors.red,
    Indicator.Available: Colors.white,
    Indicator.YourChoice: Colors.green,
    Indicator.YourPrevBook: Colors.grey.shade400,
  };

  static final borderColors = {
    Indicator.Booked: Colors.red.shade200,
    Indicator.Available: Colors.grey.shade300,
    Indicator.YourChoice: Colors.green.shade200,
    Indicator.YourPrevBook: Colors.grey.shade200,
  };
}
