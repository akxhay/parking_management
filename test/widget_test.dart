// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking/app/app.dart';
import 'package:parking/app/data/dto/response_dto.dart';
import 'package:parking/app/ui/widget/pop_up_parking_card.dart';

void main() {
  testWidgets('App Widget should render correctly',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: App(),
      ),
    );

    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('App Widget should render correctly',
          (WidgetTester tester) async {
        // Build the widget tree
        await tester.pumpWidget(
          const MaterialApp(
            home: parkingFloorFloats(),
          ),
        );

        expect(find.byType(MyApp), findsOneWidget);
      });


  testWidgets('ParkingArrivalReceiptDialog should render correctly',
      (WidgetTester tester) async {
    // Build our widget with a MaterialApp and the ParkingArrivalReceiptDialog
    await tester.pumpWidget(
      MaterialApp(
        home: ParkingArrivalReceiptDialog(
          reservedParkingSlotDto: ReservedParkingSlotDto(
            floorName: 'Floor 1',
            slotType: 's',
            slotNumber: 15,
            numberPlate: 'ABC123',
            arrivedAt: DateTime.now().millisecondsSinceEpoch,
            slotId: 1,
            floorId: 1,
          ),
        ),
      ),
    );

    expect(find.text('Parking arrival receipt'), findsOneWidget);

    expect(find.text('Floor name:'), findsOneWidget);
  });

  testWidgets('ParkingDepartureReceiptDialog should render correctly',
      (WidgetTester tester) async {
    // Build our widget with a MaterialApp and the ParkingArrivalReceiptDialog
    await tester.pumpWidget(
      MaterialApp(
        home: ParkingDepartureReceiptDialog(
          parkingSlotDto: ParkingSlotDto(
              id: 1,
              slotType: "s",
              slotNumber: 1,
              occupied: true,
              numberPlate: "ABCD123",
              arrivedAt: 12345678),
          callback: () {},
        ),
      ),
    );

    expect(find.text('Parking departure receipt'), findsOneWidget);

    expect(find.text('ABCD123'), findsOneWidget);
  });
}
