import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import 'data/dao/parking_repository.dart';
import 'data/service/bloc/parking/parking_bloc.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => ParkingRepository(),
        child: MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => ParkingLotBloc(
                    RepositoryProvider.of<ParkingRepository>(context),
                  )),
        ], child: const MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CB bot',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoute.home,
        routes: AppPages.page);
  }
}
