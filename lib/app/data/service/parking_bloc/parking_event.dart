part of 'parking_bloc.dart';

abstract class ParkingLotEvent extends Equatable {
  const ParkingLotEvent();
}

class FetchParkingLotsEvent extends ParkingLotEvent {
  final bool clear;

  const FetchParkingLotsEvent({required this.clear});

  @override
  List<Object> get props => [clear];
}

class DeleteParkingLotEvent extends ParkingLotEvent {
  final int id;

  const DeleteParkingLotEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateParkingLotEvent extends ParkingLotEvent {
  final ParkingLotRequestDto parkingLotRequestDto;

  const CreateParkingLotEvent({required this.parkingLotRequestDto});

  @override
  List<Object> get props => [parkingLotRequestDto];
}

class GetParkingSlotEvent extends ParkingLotEvent {
  final int parkingId;
  final String size;
  final String numberPlate;

  const GetParkingSlotEvent(
      {required this.parkingId, required this.size, required this.numberPlate});

  @override
  List<Object> get props => [parkingId, size, numberPlate];
}

class ReleaseParkingSlotEvent extends ParkingLotEvent {
  final int parkingId;
  final int slotId;

  const ReleaseParkingSlotEvent(
      {required this.parkingId, required this.slotId});

  @override
  List<Object> get props => [parkingId, slotId];
}
