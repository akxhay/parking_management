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
