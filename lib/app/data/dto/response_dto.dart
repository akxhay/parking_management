import 'dart:collection';

class ParkingLotPageDto {
  ParkingLotPageDto(
      {required this.totalPages,
      required this.totalElements,
      required this.parkingLots});

  int totalPages;
  int totalElements;
  List<ParkingLotResponseDto> parkingLots;

  factory ParkingLotPageDto.fromJson(Map<String, dynamic> json) {
    return ParkingLotPageDto(
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        parkingLots: json["parkingLots"] != null
            ? ParkingLotResponseDto.fromJsonArray(json["parkingLots"])
            : []);
  }

  static fromJsonArray(List<dynamic> jsonArray) {
    List<ParkingLotPageDto> entities = List.empty(growable: true);
    for (dynamic json in jsonArray) {
      entities.add(ParkingLotPageDto.fromJson(json as Map<String, dynamic>));
    }
    return entities;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["totalPages"] = totalPages;
    map["totalElements"] = totalElements;
    map["parkingLots"] = parkingLots.map((e) => e.toMap()).toList();
    return map;
  }

  @override
  String toString() {
    return 'ParkingLotPageDto{totalPages: $totalPages, totalPages: $totalPages, parkingLots: $parkingLots}';
  }
}

class ParkingLotResponseDto {
  ParkingLotResponseDto(
      {required this.id, required this.name, required this.floors});

  int id;
  String name;
  List<FloorResponseDto> floors;

  factory ParkingLotResponseDto.fromJson(Map<String, dynamic> json) {
    return ParkingLotResponseDto(
        id: json["id"],
        name: json["name"],
        floors: json["floors"] != null
            ? FloorResponseDto.fromJsonArray(json["floors"])
            : []);
  }

  @override
  String toString() {
    return 'ParkingLotResponseDto{id: $id,name: $name, floors: $floors}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["id"] = id;
    map["name"] = name;
    map["floors"] = floors.map((e) => e.toMap()).toList();

    return map;
  }

  static fromJsonArray(List<dynamic> jsonArray) {
    List<ParkingLotResponseDto> entities = List.empty(growable: true);
    for (dynamic json in jsonArray) {
      entities
          .add(ParkingLotResponseDto.fromJson(json as Map<String, dynamic>));
    }
    return entities;
  }
}

class FloorResponseDto {
  FloorResponseDto({required this.name, required this.parkingSlots});

  String name;
  List<ParkingSlotDto> parkingSlots;

  factory FloorResponseDto.fromJson(Map<String, dynamic> json) {
    return FloorResponseDto(
        name: json["name"],
        parkingSlots: json["parkingSlots"] != null
            ? ParkingSlotDto.fromJsonArray(json["parkingSlots"])
            : []);
  }

  static fromJsonArray(List<dynamic> jsonArray) {
    List<FloorResponseDto> entities = List.empty(growable: true);
    for (dynamic json in jsonArray) {
      entities.add(FloorResponseDto.fromJson(json as Map<String, dynamic>));
    }
    return entities;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["name"] = name;
    map["parkingSlots"] = parkingSlots.map((e) => e.toMap()).toList();

    return map;
  }

  @override
  String toString() {
    return 'FloorRequestDto{name: $name, parkingSlots: $parkingSlots}';
  }
}

class ParkingSlotDto {
  ParkingSlotDto(
      {required this.slotType,
      required this.slotNumber,
      required this.occupied});

  String slotType;
  int slotNumber;
  bool occupied;

  factory ParkingSlotDto.fromJson(Map<String, dynamic> json) {
    return ParkingSlotDto(
        slotType: json["slotType"],
        slotNumber: json["slotNumber"],
        occupied: json["occupied"]);
  }

  @override
  String toString() {
    return 'ParkingSlotDto{slotType: $slotType, slotType: $slotType, occupied: $occupied}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["slotType"] = slotType;
    map["slotNumber"] = slotNumber;
    map["isOccuoccupiedpied"] = occupied;
    return map;
  }

  static fromJsonArray(List<dynamic> jsonArray) {
    List<ParkingSlotDto> entities = List.empty(growable: true);
    for (dynamic json in jsonArray) {
      entities.add(ParkingSlotDto.fromJson(json as Map<String, dynamic>));
    }
    return entities;
  }
}
