part of 'parking_bloc.dart';

abstract class ParkingLotState extends Equatable {
  const ParkingLotState();
}

class FetchParkingLotLoadingState extends ParkingLotState {
  @override
  List<Object> get props => [];
}

class FetchParkingLotLoadedState extends ParkingLotState {
  final List<ParkingLotResponseDto> parkingLots;
  const FetchParkingLotLoadedState(this.parkingLots);
  @override
  List<Object?> get props => [parkingLots];
}

class FetchParkingLotErrorState extends ParkingLotState {
  final String error;
  const FetchParkingLotErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class DeleteParkingLotLoadingState extends ParkingLotState {
  @override
  List<Object> get props => [];
}

class DeleteParkingLotSuccessState extends ParkingLotState {
  final String message;
  const DeleteParkingLotSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class DeleteParkingLotErrorState extends ParkingLotState {
  final String error;
  const DeleteParkingLotErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class CreateParkingLotLoadingState extends ParkingLotState {
  @override
  List<Object> get props => [];
}

class CreateParkingLotSuccessState extends ParkingLotState {
  final ParkingLotResponseDto parkingLotResponseDto;
  const CreateParkingLotSuccessState(this.parkingLotResponseDto);
  @override
  List<Object?> get props => [parkingLotResponseDto];
}

class CreateParkingLotErrorState extends ParkingLotState {
  final String error;
  const CreateParkingLotErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class GetParkingLotLoadingState extends ParkingLotState {
  @override
  List<Object> get props => [];
}

class GetParkingLotSuccessState extends ParkingLotState {
  final AvailableParkingSlotDto availableParkingSlotDto;

  const GetParkingLotSuccessState(this.availableParkingSlotDto);

  @override
  List<Object?> get props => [availableParkingSlotDto];
}

class GetParkingLotErrorState extends ParkingLotState {
  final String error;

  const GetParkingLotErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class ReleaseParkingLotLoadingState extends ParkingLotState {
  @override
  List<Object> get props => [];
}

class ReleaseParkingLotSuccessState extends ParkingLotState {
  final String message;

  const ReleaseParkingLotSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ReleaseParkingLotErrorState extends ParkingLotState {
  final String error;

  const ReleaseParkingLotErrorState(this.error);

  @override
  List<Object?> get props => [error];
}