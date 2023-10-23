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
  FloorResponseDto(
      {required this.id, required this.name, required this.parkingSlots});

  int id;

  String name;
  List<ParkingSlotDto> parkingSlots;

  factory FloorResponseDto.fromJson(Map<String, dynamic> json) {
    return FloorResponseDto(
        id: json["id"],
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
    map["id"] = id;
    map["name"] = name;
    map["parkingSlots"] = parkingSlots.map((e) => e.toMap()).toList();

    return map;
  }

  @override
  String toString() {
    return 'FloorRequestDto{id: $id,name: $name, parkingSlots: $parkingSlots}';
  }
}

class ParkingSlotDto {
  ParkingSlotDto(
      {required this.id,
      required this.slotType,
      required this.slotNumber,
      required this.occupied,
      required this.numberPlate,
      required this.arrivedAt});

  int id;
  String slotType;
  int slotNumber;
  bool occupied;
  String? numberPlate;
  int? arrivedAt;

  factory ParkingSlotDto.fromJson(Map<String, dynamic> json) {
    return ParkingSlotDto(
        id: json["id"],
        slotType: json["slotType"],
        slotNumber: json["slotNumber"],
        occupied: json["occupied"],
        numberPlate: json["numberPlate"],
        arrivedAt: json["arrivedAt"]);
  }

  @override
  String toString() {
    return 'ParkingSlotDto{id: $id,slotType: $slotType, slotType: $slotType, occupied: $occupied, numberPlate: $numberPlate, arrivedAt: $arrivedAt}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["id"] = id;
    map["slotType"] = slotType;
    map["slotNumber"] = slotNumber;
    map["occupied"] = occupied;
    map["numberPlate"] = numberPlate;
    map["arrivedAt"] = arrivedAt;
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

class ReservedParkingSlotDto {
  ReservedParkingSlotDto(
      {required this.slotId,
      required this.slotType,
      required this.slotNumber,
      required this.floorId,
      required this.floorName,
      required this.numberPlate,
      required this.arrivedAt});

  int slotId;
  String slotType;
  int slotNumber;
  int floorId;
  String floorName;
  String? numberPlate;
  int? arrivedAt;

  factory ReservedParkingSlotDto.fromJson(Map<String, dynamic> json) {
    return ReservedParkingSlotDto(
        slotId: json["slotId"],
        slotType: json["slotType"],
        slotNumber: json["slotNumber"],
        floorId: json["floorId"],
        floorName: json["floorName"],
        numberPlate: json["numberPlate"],
        arrivedAt: json["arrivedAt"]);
  }

  @override
  String toString() {
    return 'AvailableParkingSlotDto{slotId: $slotId, slotType: $slotType, slotNumber: $slotNumber, floorId: $floorId, floorName: $floorName, numberPlate: $numberPlate, arrivedAt: $arrivedAt}';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["slotId"] = slotId;
    map["slotType"] = slotType;
    map["slotNumber"] = slotNumber;
    map["floorId"] = floorId;
    map["floorName"] = floorName;
    map["numberPlate"] = numberPlate;
    map["arrivedAt"] = arrivedAt;
    return map;
  }
}
