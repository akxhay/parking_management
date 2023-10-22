import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:parking/app/data/dto/response_dto.dart';
import 'package:parking/app/ui/modules/parking_lot.dart';
import 'package:parking/app/widget/loaders.dart';

import '../../data/service/bloc/parking/parking_bloc.dart';
import '../../util/common_method.dart';
import 'add_new_lot.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  int? deleteId;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    context
        .read<ParkingLotBloc>()
        .add(const FetchParkingLotsEvent(clear: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Home"), actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              onPressed: () {
                context
                    .read<ParkingLotBloc>()
                    .add(const FetchParkingLotsEvent(clear: true));
              }),
        ]),
        backgroundColor: Colors.white,
        floatingActionButton: parkManagementFloats(context),
        body: BlocConsumer<ParkingLotBloc, ParkingLotState>(
            listener: (context, state) {
          if (state is DeleteParkingLotLoadingState) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => loadingIndicator(context, "deleting parking lot"));
          } else if (state is DeleteParkingLotSuccessState) {
            Navigator.of(context, rootNavigator: true).pop();

            CommonMethods.showToast(
                context: context, text: state.message, seconds: 2);
            setState(() {
              setState(() {
                context
                    .read<ParkingLotBloc>()
                    .parkingLots
                    .removeWhere((item) => item.id == deleteId);
              });
              deleteId = null;
            });
          } else if (state is DeleteParkingLotErrorState) {
            Navigator.of(context, rootNavigator: true).pop();

            setState(() {
              deleteId = null;
            });
            CommonMethods.showToast(
                context: context, text: state.error, seconds: 2);
          }
        }, buildWhen: (prev, curr) {
          return curr is FetchParkingLotLoadedState;
        }, builder: (context, state) {
          return showParkingLots();
        }));
  }

  Widget showParkingLots() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: [
          // Box shadow for subtle elevation effect
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(
        5.0,
        MediaQuery.of(context).size.height * .01,
        5.0,
        0.0,
      ),
      child: Column(
        children: [
          Expanded(
            // Use expanded instead of a specific maxHeight for flexibility.
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              // Consistent margin
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                // Padding for inner content
                padding: const EdgeInsets.all(8.0),
                child: buildStream(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStream() {
    return BlocConsumer<ParkingLotBloc, ParkingLotState>(
      listener: (ctx, st) {
        if (st is FetchParkingLotLoadingState) {
          CommonMethods.showToast(
              context: context, text: "Loading...", seconds: 1);
        } else if (st is FetchParkingLotLoadedState && st.parkingLots.isEmpty) {
          CommonMethods.showToast(
              context: context, text: "No more photos...", seconds: 1);
        } else if (st is FetchParkingLotErrorState) {
          CommonMethods.showToast(context: context, text: st.error, seconds: 1);
          context.read<ParkingLotBloc>().isFetching = false;
        }
        return;
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<ParkingLotBloc>()
                .add(const FetchParkingLotsEvent(clear: true));
          },
          child: CustomScrollView(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.read<ParkingLotBloc>().isFetching) {
                  context.read<ParkingLotBloc>()
                    ..isFetching = true
                    ..add(const FetchParkingLotsEvent(clear: false));
                }
              }),
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (state is FetchParkingLotErrorState &&
                          context.read<ParkingLotBloc>().parkingLots.isEmpty) {
                        return Center(
                          child: Text('Error: ${state.error}'),
                        );
                      }

                      if (state is FetchParkingLotLoadingState &&
                          context.read<ParkingLotBloc>().parkingLots.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }

                      if (state is FetchParkingLotLoadedState) {
                        context.read<ParkingLotBloc>().isFetching = false;
                      }
                      return buildParkingLot(
                          context.read<ParkingLotBloc>().parkingLots[index]);
                    },
                    childCount:
                        context.read<ParkingLotBloc>().parkingLots.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildParkingLot(ParkingLotResponseDto parkingLot) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            parkingLot.name,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.blue,
            ),
            overflow: TextOverflow.visible,
            maxLines: 1,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ParkingLotPage(
                    parkingLot: parkingLot,
                  ))),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
                  ),
                  onPressed: () {
                    deleteItem(context, parkingLot.id);
                  },
          ),
        ),
        const Divider(
          // Add a border below the ListTile
          height: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  void deleteItem(BuildContext context, int id) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Delete Item',
                style: TextStyle(),
              ),
              content: const Text(
                'Press OK to delete Item',
                style: TextStyle(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    setState(() {
                      deleteId = id;
                    });
                    BlocProvider.of<ParkingLotBloc>(context)
                        .add(DeleteParkingLotEvent(id));
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ));
  }

  Widget parkManagementFloats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        addFloat(Colors.blue),
      ]),
    );
  }

  Widget addFloat(MaterialColor color) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNewParkingLotPage(
                      callback: (ParkingLotResponseDto e) {
                        setState(() {
                          context
                              .read<ParkingLotBloc>()
                              .parkingLots
                              .insert(0, e);
                        });
                      },
                    )));
      },
      tooltip: 'Create new',
      heroTag: null,
      backgroundColor: color,
      child: const Icon(Icons.add),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
