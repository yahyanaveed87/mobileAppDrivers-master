// ignore_for_file: invalid_use_of_protected_member, duplicate_ignore, use_super_parameters

import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:get/get_core/src/get_main.dart';
import 'package:space_shuttle_driver/controllers/ArrivalsController.dart';
import 'package:space_shuttle_driver/controllers/DeparturesController.dart';
import 'package:space_shuttle_driver/controllers/ShuttlesController.dart';
import 'package:space_shuttle_driver/utils/colors.dart';
import 'package:space_shuttle_driver/widgets/arrival_tile.dart';
import 'package:space_shuttle_driver/widgets/departure_tile.dart';
import 'package:space_shuttle_driver/widgets/pickup_tile_arrival.dart';
import 'package:space_shuttle_driver/widgets/pickup_tile_departure.dart';
import 'package:space_shuttle_driver/widgets/rounded_button.dart';
import 'package:space_shuttle_driver/widgets/rounded_button_toggle.dart';
import 'package:timer_builder/timer_builder.dart';
import '../controllers/PositionController.dart';
import '../controllers/StaffController.dart';
import '../model/Shuttle.dart';
import 'package:space_shuttle_driver/utils/constants.dart';
import 'package:space_shuttle_driver/screens/login_page.dart';

//this is a useless comment for absolutely no reason at all...
class Homepage extends StatefulWidget {
  final staffController = Get.find<StaffController>();
  final shuttleController = Get.put(ShuttlesController());
  final arrivalsController = Get.put(ArrivalsController());
  final departuresController = Get.put(DeparturesController());
  final positionController = Get.put(PositionController());

  // ignore: use_super_parameters
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabControllerInt;
  late TabController _tabControllerDom;

  int currentIndex = 0;

  @override
  void initState() {
    _tabControllerInt = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = _tabControllerInt.index;
        });
      });

    _tabControllerDom = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = _tabControllerDom.index;
        });
      });

    widget.staffController.updateCurrentStatus('At Base');
    // widget.positionController.observePosition(widget.staffController.activeShuttle.value.toString());
    widget.departuresController.observeDepartures();
    widget.arrivalsController.observeArrivals();
    super.initState();
  }

  @override
  void dispose() {
    widget.positionController.disposeObservers();
    widget.staffController.disposeObservers();
    widget.shuttleController.disposeObservers();
    widget.arrivalsController.disposeObservers();
    widget.departuresController.disposeObservers();

    super.dispose();
  }

  @override
  void didUpdateWidget(Homepage oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.staffController.updateCurrentStatus('At Base');
    widget.departuresController.observeDepartures();
    widget.arrivalsController.observeArrivals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  height: 500,
                  width: double.infinity,
                  color: whiteShade,
                  child: Obx(
                    () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${widget.staffController.getActiveStaff()?.name}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder(
                                      future: widget.staffController
                                          .getActiveDriverTimestamp(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return TimerBuilder.periodic(
                                              const Duration(seconds: 1),
                                              builder: (context) {
                                            Duration duration = DateTime.now()
                                                .difference(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        snapshot.data ?? 0))
                                                .abs();
                                            var hours = duration.inHours;
                                            var minutes = duration.inMinutes;
                                            return Text(
                                              'Started: ${duration.inHours} hours ${minutes - (hours * 60)} minutes ago',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          });
                                        } else {
                                          return const Text('Loading...');
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    Obx(
                                      () => Text(
                                        'Your Shuttle: ${widget.shuttleController.activeShuttle.value}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*RoundedButton(
                            bgColor: Colors.green,
                            labelColor: Colors.white,
                            width: 150,
                            height: 70,
                            borderRadius: 50,
                            label: 'Get Location',
                            onClick: () {
                              Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
                                print('POSITION_DEBUG: ${value.latitude}, ${value.longitude}');
                              }, onError: (error) {
                                print('POSITION_DEBUG: $error');
                              }, );

                            }),*/
                            ],
                          ),
                          const SizedBox(height: 10),
                          RoundedButton(
                              bgColor: orangeGradient[1],
                              labelColor: Colors.white,
                              width: 100,
                              height: 30,
                              borderRadius: 10,
                              label: 'Sign Out',
                              onClick: () {
                                widget.staffController.signOff();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.le,
                            children: [
                              const Text(
                                'Other Shuttles',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 20),
                              Obx(
                                () {
                                  if (widget
                                          .arrivalsController
                                          .pickedUpArrivals
                                          // ignore: invalid_use_of_protected_member
                                          .value
                                          .isNotEmpty ||
                                      widget
                                          .departuresController
                                          .pickedUpDepartures
                                          // ignore: invalid_use_of_protected_member
                                          .value
                                          .isNotEmpty) {
                                    return TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.all(10),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                        onPressed: () {
                                          if (widget.staffController
                                                      .currentStatus.value ==
                                                  'At Domestic' ||
                                              widget.staffController
                                                      .currentStatus.value ==
                                                  'At International') {
                                            widget.departuresController
                                                .dropEveryoneOff();
                                          } else if (widget.staffController
                                                  .currentStatus.value ==
                                              'At Base') {
                                            widget.arrivalsController
                                                .dropEveryoneOff();
                                          } else {
                                            showGetSnackbar(
                                                'Invalid shuttle status',
                                                'Must be at domestic/internation or at base!');
                                          }
                                        },
                                        child: const Text(
                                          'Finish Dropoff',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ));
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                color: whiteShade,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 100,
                                height: 120,
                                child: Obx(() => ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.shuttleController.shuttles
                                        .where((p0) =>
                                            p0.driver !=
                                            widget.staffController
                                                .getActiveStaff()
                                                ?.name)
                                        .toList()
                                        .length,
                                    itemBuilder: (context, index) {
                                      return ShuttleButton(
                                          shuttle: widget
                                              .shuttleController.shuttles
                                              .where((p0) =>
                                                  p0.driver !=
                                                  widget.staffController
                                                      .getActiveStaff()
                                                      ?.name)
                                              .toList()[index]);
                                    })),
                              ),
                              Container(
                                color: whiteShade,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 100,
                                height: 120,
                                child: Obx(() {
                                  if ((widget.staffController.currentStatus
                                                  .value ==
                                              'At Domestic' ||
                                          widget.staffController.currentStatus
                                                  .value ==
                                              'To Base' ||
                                          widget.staffController.currentStatus
                                                  .value ==
                                              'At International') &&
                                      // ignore: duplicate_ignore
                                      widget
                                          .arrivalsController
                                          .pickedUpArrivals
                                          // ignore: invalid_use_of_protected_member
                                          .value
                                          .isNotEmpty) {
                                    return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return TimerBuilder.periodic(
                                              const Duration(minutes: 1),
                                              builder: (context) {
                                            return InkWell(
                                              onTap: () {
                                                widget.arrivalsController
                                                    .removePickup(widget
                                                        .arrivalsController
                                                        .pickedUpArrivals
                                                        .value[index]);
                                              },
                                              child: PickupTileArrival(
                                                  arrival: widget
                                                      .arrivalsController
                                                      .pickedUpArrivals
                                                      .value[index]),
                                            );
                                          });
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 10,
                                            ),
                                        itemCount: widget.arrivalsController
                                            .pickedUpArrivals.value.length);
                                  } else if ((widget.staffController
                                                  .currentStatus.value ==
                                              'At Base' ||
                                          widget.staffController.currentStatus
                                                  .value ==
                                              'To Domestic' ||
                                          widget.staffController.currentStatus
                                                  .value ==
                                              'To International') &&
                                      widget
                                          .departuresController
                                          .pickedUpDepartures
                                          .value
                                          .isNotEmpty) {
                                    return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return TimerBuilder.periodic(
                                              const Duration(minutes: 1),
                                              builder: (context) {
                                            return InkWell(
                                              onTap: () {
                                                widget.departuresController
                                                    .removePickup(widget
                                                        .departuresController
                                                        .pickedUpDepartures
                                                        .value[index]);
                                              },
                                              child: PickupTileDeparture(
                                                  dropOff: widget
                                                      .departuresController
                                                      .pickedUpDepartures
                                                      .value[index]),
                                            );
                                          });
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 10,
                                            ),
                                        itemCount: widget.departuresController
                                            .pickedUpDepartures.value.length);
                                  } else {
                                    // return const Center(child: Text('Customers you pickup will show here'));
                                    return const SizedBox();
                                  }
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Your Status',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: [
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'To Base',
                                      label: 'To Base',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('To Base');
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'To International',
                                      label: 'To International',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('To International');
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'To Domestic',
                                      label: 'To Domestic',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('To Domestic');
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'At Base',
                                      label: 'At Base',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('At Base');
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'At International',
                                      label: 'At International',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('At International');
                                      }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  RoundedButtonToggle(
                                      width: 150,
                                      height: 70,
                                      borderRadius: 50,
                                      active: widget.staffController
                                              .currentStatus.value ==
                                          'At Domestic',
                                      label: 'At Domestic',
                                      onClick: () {
                                        widget.staffController
                                            .updateStatus('At Domestic');
                                      }),
                                ],
                              ),
                            );
                          })
                        ],
                      );
                    },
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customers',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 600,
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            children: [
                              const Text(
                                'Airport',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              TabBar(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey,
                                  controller: _tabControllerInt,
                                  tabs: [
                                    Obx(() => Tab(
                                          text:
                                              'Domestic (${widget.arrivalsController.domesticArrivals.value.length})',
                                        )),
                                    Obx(() => Tab(
                                          text:
                                              'International (${widget.arrivalsController.internationalArrivals.value.length})',
                                        )),
                                  ]),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: TabBarView(
                                      controller: _tabControllerInt,
                                      children: [
                                    Obx(() {
                                      if (widget.arrivalsController
                                          .domesticArrivals.value.isNotEmpty) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return TimerBuilder.periodic(
                                                  const Duration(minutes: 1),
                                                  builder: (context) {
                                                return ArrivalTile(
                                                  arrival: widget
                                                      .arrivalsController
                                                      .domesticArrivals
                                                      .value[index],
                                                  onTap: () {
                                                    if (widget
                                                            .staffController
                                                            .currentStatus
                                                            .value ==
                                                        'At Domestic') {
                                                      widget.arrivalsController
                                                          .addPickup(widget
                                                              .arrivalsController
                                                              .domesticArrivals
                                                              .value[index]);
                                                      widget.staffController
                                                          .updateStatus(
                                                              'To Base');
                                                    } else {
                                                      showGetSnackbar(
                                                          'Heads up!',
                                                          'Shuttle should be at domestic to pickup.');
                                                    }
                                                  },
                                                );
                                              });
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount: widget.arrivalsController
                                                .domesticArrivals.value.length);
                                      } else {
                                        return const Center(
                                            child: Text(
                                          'No domestic arrivals',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ));
                                      }
                                    }),
                                    Obx(() {
                                      if (widget
                                          .arrivalsController
                                          .internationalArrivals
                                          .value
                                          .isNotEmpty) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return TimerBuilder.periodic(
                                                  const Duration(minutes: 1),
                                                  builder: (context) {
                                                return ArrivalTile(
                                                  arrival: widget
                                                      .arrivalsController
                                                      .internationalArrivals
                                                      .value[index],
                                                  onTap: () {
                                                    if (widget
                                                            .staffController
                                                            .currentStatus
                                                            .value ==
                                                        'At International') {
                                                      widget.arrivalsController
                                                          .addPickup(widget
                                                              .arrivalsController
                                                              .internationalArrivals
                                                              .value[index]);
                                                      widget.staffController
                                                          .updateStatus(
                                                              'To Base');
                                                    } else {
                                                      showGetSnackbar(
                                                          'Heads up!',
                                                          'Shuttle should be at international to pickup.');
                                                    }
                                                  },
                                                );
                                              });
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount: widget
                                                .arrivalsController
                                                .internationalArrivals
                                                .value
                                                .length);
                                      } else {
                                        return const Center(
                                            child: Text(
                                          'No international arrivals',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ));
                                      }
                                    })
                                  ]))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 600,
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            children: [
                              const Text(
                                'Car Park',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              TabBar(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey,
                                  controller: _tabControllerDom,
                                  tabs: [
                                    Obx(() => Tab(
                                          text:
                                              'Domestic (${widget.departuresController.domesticDepartures.value.length})',
                                        )),
                                    Obx(() => Tab(
                                          text:
                                              'International (${widget.departuresController.internalDepartures.value.length})',
                                        )),
                                  ]),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: TabBarView(
                                      controller: _tabControllerDom,
                                      children: [
                                    Obx(() {
                                      if (widget
                                          .departuresController
                                          .domesticDepartures
                                          .value
                                          .isNotEmpty) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return TimerBuilder.periodic(
                                                  const Duration(minutes: 1),
                                                  builder: (context) {
                                                return DepartureTile(
                                                  dropOff: widget
                                                      .departuresController
                                                      .domesticDepartures
                                                      .value[index],
                                                  onTap: () {
                                                    if (widget
                                                            .staffController
                                                            .currentStatus
                                                            .value ==
                                                        'At Base') {
                                                      widget
                                                          .departuresController
                                                          .addPickup(widget
                                                              .departuresController
                                                              .domesticDepartures
                                                              .value[index]);
                                                      widget.staffController
                                                          .updateStatus(
                                                              'To Domestic');
                                                    } else {
                                                      showGetSnackbar(
                                                          'Heads up!',
                                                          'Shuttle should be at base to pickup.');
                                                    }
                                                  },
                                                );
                                              });
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount: widget
                                                .departuresController
                                                .domesticDepartures
                                                .value
                                                .length);
                                      } else {
                                        return const Center(
                                            child: Text(
                                          'No domestic departures',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ));
                                      }
                                    }),
                                    Obx(() {
                                      if (widget
                                          .departuresController
                                          .internalDepartures
                                          .value
                                          .isNotEmpty) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return TimerBuilder.periodic(
                                                  const Duration(minutes: 1),
                                                  builder: (context) {
                                                return DepartureTile(
                                                  dropOff: widget
                                                      .departuresController
                                                      .internalDepartures
                                                      .value[index],
                                                  onTap: () {
                                                    if (widget
                                                            .staffController
                                                            .currentStatus
                                                            .value ==
                                                        'At Base') {
                                                      widget
                                                          .departuresController
                                                          .addPickup(widget
                                                              .departuresController
                                                              .internalDepartures
                                                              .value[index]);
                                                      widget.staffController
                                                          .updateStatus(
                                                              'To International');
                                                    } else {
                                                      showGetSnackbar(
                                                          'Heads up!',
                                                          'Shuttle should be at base to pickup.');
                                                    }
                                                  },
                                                );
                                              });
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount: widget
                                                .departuresController
                                                .internalDepartures
                                                .value
                                                .length);
                                      } else {
                                        return const Center(
                                            child: Text(
                                          'No international departures',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ));
                                      }
                                    })
                                  ]))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ShuttleButton extends StatelessWidget {
  const ShuttleButton({Key? key, required this.shuttle}) : super(key: key);
  final Shuttle shuttle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 100,
      height: 50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*const SizedBox(
              width: 50,
              height: 50,
              child: Image(image: AssetImage('assets/images/van3d.png')),
            ),*/
            Text(
              shuttle.driver,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              shuttle.registration,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              shuttle.status,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 10),
            ),
            TimerBuilder.periodic(const Duration(hours: 1), builder: (context) {
              return Text(
                  '${(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(shuttle.statusTimestamp)).inHours).toStringAsFixed(2)} hrs ago',
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                      fontSize: 10));
            })
          ],
        ),
      ),
    );
  }
}
