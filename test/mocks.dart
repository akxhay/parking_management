import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:parking/app/data/service/parking_bloc/parking_bloc.dart';

class MockParkingLotBloc extends Mock implements ParkingLotBloc {
  MockParkingLotBloc() {
    when(stream).thenAnswer((_) => const Stream.empty());
  }
}

class MockBuildContext extends Mock implements BuildContext{}