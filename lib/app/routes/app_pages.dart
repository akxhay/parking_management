import 'package:flutter/material.dart';

import '../ui/pages/add_new_parking_lot.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/parking_floor_page.dart';
import '../ui/pages/parking_lot_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final Map<String, Widget Function(dynamic)> page = {
    AppRoute.home: (_) => const MyHomePage(),
    AppRoute.parkingLot: (context) => ParkingLotPage(context: context),
    AppRoute.parkingFloor: (context) => ParkingFloorPage(context: context),
    AppRoute.addParkingLot: (context) => AddNewParkingLotPage(context: context),
  };
}
