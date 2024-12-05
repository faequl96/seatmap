part of '../seat_map_widget.dart';

class Compartment {
  const Compartment({this.name = "", this.columnItems = const []});

  final String name;
  final List<ColumnItem> columnItems;
}

class ColumnItem {
  const ColumnItem({this.id = "", this.rowItems = const []});

  final String id;
  final List<RowItem> rowItems;
}

class RowItem {
  const RowItem({
    required this.id,
    required this.row,
    required this.column,
    required this.type,
    this.status = RowItemStatus.Disabled,
  });

  final String id;
  final String row;
  final String column;
  final RowItemType type;
  final RowItemStatus status;
}

class PaxTicket {
  PaxTicket({
    this.paxIdNumber = "",
    this.paxName = "",
    this.ticketNo = "",
    this.compartmentId = "",
    this.seatId = "",
    this.seatNo = "",
    this.column = "",
    this.row = "",
  });

  final String paxIdNumber;
  final String paxName;
  final String ticketNo;
  final String compartmentId;
  final String seatId;
  final String seatNo;
  final String column;
  final String row;
}
