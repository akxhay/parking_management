import 'dart:collection';

class ParkingLotRequestDto {
  ParkingLotRequestDto({required this.name, required this.floors});

  String name;
  List<FloorRequestDto> floors;

  factory ParkingLotRequestDto.fromJson(Map<String, dynamic> json) {
    return ParkingLotRequestDto(
        name: json["name"],
        floors: json["floors"] != null
            ? FloorRequestDto.fromJsonArray(json["floors"])
            : []);
  }

  @override
  String toString() {
    return 'ParkingLotRequestDto{name: $name, floors: $floors}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["name"] = name;
    map["floors"] = floors.map((e) => e.toMap()).toList();

    return map;
  }
}

class FloorRequestDto {
  FloorRequestDto(
      {required this.name,
      required this.smallSlots,
      required this.mediumSlots,
      required this.largeSlots,
      required this.xLargeSlots});

  String name;
  int smallSlots;
  int mediumSlots;
  int largeSlots;
  int xLargeSlots;

  factory FloorRequestDto.fromJson(Map<String, dynamic> json) {
    return FloorRequestDto(
      name: json["name"],
      smallSlots: json["smallSlots"],
      mediumSlots: json["mediumSlots"],
      largeSlots: json["largeSlots"],
      xLargeSlots: json["xLargeSlots"],
    );
  }

  static fromJsonArray(List<dynamic> jsonArray) {
    List<FloorRequestDto> entities = List.empty(growable: true);
    for (dynamic json in jsonArray) {
      entities.add(FloorRequestDto.fromJson(json as Map<String, dynamic>));
    }
    return entities;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["name"] = name;
    map["smallSlots"] = smallSlots;
    map["mediumSlots"] = mediumSlots;
    map["largeSlots"] = largeSlots;
    map["xLargeSlots"] = xLargeSlots;

    return map;
  }

  @override
  String toString() {
    return 'FloorRequestDto{name: $name, smallSlots: $smallSlots, mediumSlots: $mediumSlots, largeSlots: $largeSlots, xLargeSlots: $xLargeSlots}';
  }
}

class DummyDto {
  DummyDto(
      {required this.parkingLots,
      required this.floorsPerParkingLot,
      required this.smallSlotsPerFloor,
      required this.mediumSlotsPerFloor,
      required this.largeSlotsPerFloor,
      required this.xLargeSlotsPerFloor});

  int parkingLots;
  int floorsPerParkingLot;
  int smallSlotsPerFloor;
  int mediumSlotsPerFloor;
  int largeSlotsPerFloor;
  int xLargeSlotsPerFloor;

  factory DummyDto.fromJson(Map<String, dynamic> json) {
    return DummyDto(
        parkingLots: json["parkingLots"],
        floorsPerParkingLot: json["floorsPerParkingLot"],
        smallSlotsPerFloor: json["smallSlotsPerFloor"],
        mediumSlotsPerFloor: json["mediumSlotsPerFloor"],
        largeSlotsPerFloor: json["largeSlotsPerFloor"],
        xLargeSlotsPerFloor: json["xLargeSlotsPerFloor"]);
  }

  @override
  String toString() {
    return 'ParkingLotRequestDto{parkingLots: $parkingLots, floorsPerParkingLot: $floorsPerParkingLot,smallSlotsPerFloor: $smallSlotsPerFloor, mediumSlotsPerFloor: $mediumSlotsPerFloor,largeSlotsPerFloor: $largeSlotsPerFloor,xLargeSlotsPerFloor: $xLargeSlotsPerFloor}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["parkingLots"] = parkingLots;
    map["parkingLots"] = parkingLots;
    map["smallSlotsPerFloor"] = smallSlotsPerFloor;
    map["mediumSlotsPerFloor"] = mediumSlotsPerFloor;
    map["largeSlotsPerFloor"] = largeSlotsPerFloor;
    map["xLargeSlotsPerFloor"] = xLargeSlotsPerFloor;

    return map;
  }
}
