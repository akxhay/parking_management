import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/dto/request_dto.dart';
import 'package:parking/app/data/dto/response_dto.dart';

import '../../../dao/parking_repository.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingLotBloc extends Bloc<ParkingLotEvent, ParkingLotState> {
  final ParkingRepository _parkingRepository;
  int page = 0;
  int size = 20;

  bool isFetching = false;
  final List<ParkingLotResponseDto> parkingLots = [];

  ParkingLotBloc(this._parkingRepository)
      : super(FetchParkingLotLoadingState()) {
    on<ParkingLotEvent>(_onLoadForm);
  }

  Future<void> _onLoadForm(
      ParkingLotEvent event, Emitter<ParkingLotState> emit) async {
    if (event is FetchParkingLotsEvent) {
      log("emitting loading state");
      emit(FetchParkingLotLoadingState());
      try {
        if (event.clear) {
          page = 0;
          size = 20;
          parkingLots.clear();
        }
        var response = await _parkingRepository.fetchItems(page, size);

        if (response.statusCode == 200) {
          final dynamic map =
              convert.jsonDecode(utf8.decode(response.bodyBytes)) as dynamic;
          if (map.isNotEmpty) {
            log("emitting loaded state");
            ParkingLotPageDto dto = ParkingLotPageDto.fromJson(map);
            log("dto : $dto");
            parkingLots.addAll(dto.parkingLots);
            emit(FetchParkingLotLoadedState(parkingLots));
            page++;
          } else {
            log("emitting error state 1");
            emit(const FetchParkingLotErrorState("No item available"));
          }
        } else if (response.statusCode == HttpStatus.noContent) {
          log("emitting error state 2");
          emit(const FetchParkingLotErrorState("content not found"));
        } else {
          log("emitting error state 3");
          emit(const FetchParkingLotErrorState("Could not fetch items"));
        }
      } catch (e) {
        log("emitting error state 4$e");
        emit(FetchParkingLotErrorState(e.toString()));
      }
    } else if (event is DeleteParkingLotEvent) {
      log("emitting loading state");
      emit(DeleteParkingLotLoadingState());
      try {
        var response = await _parkingRepository.deleteItem(event.props[0]);
        if (response.statusCode == HttpStatus.ok) {
          log("emitting loaded state");
          emit(DeleteParkingLotSuccessState(response.body));
        } else if (response.statusCode == HttpStatus.notFound) {
          log("emitting error state 2");
          emit(const DeleteParkingLotErrorState("content not found"));
        } else {
          log("emitting error state 3");
          emit(const DeleteParkingLotErrorState("Could not save items"));
        }
      } catch (e) {
        log("emitting error state 4$e");
        emit(DeleteParkingLotErrorState(e.toString()));
      }
    } else if (event is CreateParkingLotEvent) {
      log("emitting loading state");
      emit(CreateParkingLotLoadingState());
      try {
        var response =
            await _parkingRepository.createItem(event.parkingLotRequestDto);
        if (response.statusCode == HttpStatus.created) {
          final Map<String, dynamic> dynamicMap =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          if (dynamicMap.isNotEmpty) {
            log("emitting loaded state");
            emit(CreateParkingLotSuccessState(dynamicMap["message"]));
          } else {
            log("emitting error state 1");
            emit(const CreateParkingLotErrorState("Item not found"));
          }
        } else if (response.statusCode == HttpStatus.notFound) {
          log("emitting error state 2");
          emit(const CreateParkingLotErrorState("content not found"));
        } else {
          log("emitting error state 3");
          emit(const CreateParkingLotErrorState("Could not save items"));
        }
      } catch (e) {
        log("emitting error state 4$e");
        emit(CreateParkingLotErrorState(e.toString()));
      }
    } else if (event is GetParkingSlotEvent) {
      log("emitting loading state");
      emit(GetParkingLotLoadingState());
      try {
        var response =
            await _parkingRepository.getSlot(event.parkingId, event.size);
        if (response.statusCode == HttpStatus.ok) {
          final Map<String, dynamic> map =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          if (map.isNotEmpty) {
            log("emitting loaded state");
            emit(GetParkingLotSuccessState(
                AvailableParkingSlotDto.fromJson(map)));
          } else {
            log("emitting error state 1");
            emit(const GetParkingLotErrorState("Item not found"));
          }
        } else if (response.statusCode == HttpStatus.notFound) {
          log("emitting error state 2");
          emit(const GetParkingLotErrorState("Parking slot not available"));
        } else {
          log("emitting error state 3");
          emit(const GetParkingLotErrorState("Could not save items"));
        }
      } catch (e) {
        log("emitting error state 4$e");
        emit(GetParkingLotErrorState(e.toString()));
      }
    } else if (event is ReleaseParkingSlotEvent) {
      log("emitting loading state");
      emit(ReleaseParkingLotLoadingState());
      try {
        var response =
            await _parkingRepository.releaseSlot(event.parkingId, event.slotId);
        if (response.statusCode == HttpStatus.ok) {
          if (response.body.isNotEmpty) {
            log("emitting loaded state");
            emit(ReleaseParkingLotSuccessState(response.body));
          } else {
            log("emitting error state 1");
            emit(const ReleaseParkingLotErrorState("Item not found"));
          }
        } else if (response.statusCode == HttpStatus.notFound) {
          log("emitting error state 2");
          emit(const ReleaseParkingLotErrorState("content not found"));
        } else {
          log("emitting error state 3");
          emit(const ReleaseParkingLotErrorState("Could not save items"));
        }
      } catch (e) {
        log("emitting error state 4$e");
        emit(ReleaseParkingLotErrorState(e.toString()));
      }
    }
  }
}
