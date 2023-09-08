import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/drawer.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SocketGroup0 {
  String? angka;
  double? dyeingJet1;
  double? dyeingJet2;
  double? dyeingJet3;
  double? dyeingJet4;

  SocketGroup0(
    this.angka,
    this.dyeingJet1,
    this.dyeingJet2,
    this.dyeingJet3,
    this.dyeingJet4,
  );
  @override
  String toString() {
    return '{angka:$angka, dyeingJet1: $dyeingJet1, dyeingJet2: $dyeingJet2, dyeingJet3: $dyeingJet3, dyeingJet4: $dyeingJet4}';
  }
}

class SocketGroup1 {
  String? angka;
  double? dyeingJet5;
  double? dyeingJet6;
  double? dyeingJet7;
  double? dyeingJet8;

  SocketGroup1(
    this.angka,
    this.dyeingJet5,
    this.dyeingJet6,
    this.dyeingJet7,
    this.dyeingJet8,
  );
  @override
  String toString() {
    return '{angka:$angka, dyeingJet5: $dyeingJet5, dyeingJet6: $dyeingJet6, dyeingJet7: $dyeingJet7, dyeingJet8: $dyeingJet8}';
  }
}

class SocketGroup2 {
  String? angka;
  double? dyeingJet9;
  double? dyeingJet10;

  SocketGroup2(
    this.angka,
    this.dyeingJet9,
    this.dyeingJet10,
  );
  @override
  String toString() {
    return '{angka:$angka, dyeingJet5: $dyeingJet9, dyeingJet6: $dyeingJet10}';
  }
}

class GrafikDyeingJet extends StatefulWidget {
  const GrafikDyeingJet({super.key});

  @override
  State<GrafikDyeingJet> createState() => _GrafikDyeingJetState();
}

class _GrafikDyeingJetState extends State<GrafikDyeingJet> {
  String device = " ";
  List<SocketGroup0> listGroup0 = [];
  List<SocketGroup1> listGroup1 = [];
  List<SocketGroup2> listGroup2 = [];
  var reverseGroup0, reverseGroup1, reverseGroup2;
  var dyeingJet20, dyeingJet21, dyeingJet22, dyeingJet23, dyeingJet24, dyeingJet25, dyeingJet26, dyeingJet27, dyeingJet28, dyeingJet29, tekananUap;
  var valuedj20, valuedj21, valuedj22, valuedj23, valuedj24, valuedj25, valuedj26, valuedj27, valuedj28, valuedj29;
  Future<MqttServerClient> connect() async {
    MqttServerClient client = MqttServerClient.withPort(
      'mq01.sipatex.co.id',
      '$device',
      8838,
    );
    client.logging(on: true);
    client.onConnected = () {
      print('connected');
    };
    client.onDisconnected = () {
      print('disconnected');
      MyDialog.dialogFailed(context, "Disconnected");
    };
    // client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = (String topic) {
      print('subscribed to $topic');
    };
    client.onSubscribeFail = (String topic) {
      print('failed to subscribe to $topic');
      MyDialog.dialogFailed(context, "Failed subscribed to $topic");
    };
    client.pongCallback = () {
      print('ping response arrived');
    };
    client.secure = true;

    final connMessage = MqttConnectMessage()
        .authenticateAs('it', 'it1234')
        .keepAliveFor(60)
        .withWillTopic('Will Topics')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      var date = DateFormat('HH:mm:ss').format(DateTime.now());
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final String payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);

      ///////////////////////
      if (c[0].topic == "/2022/Majalaya/JetDyeing-Group0/temperature") {
        var data = payload.split(';');
        print("DATA DG-0: $data");
        setState(() {
          if (listGroup0.length >= 21) {
            listGroup0.removeAt(0);
          }

          // print(data[0].split(',')[0]);
          dyeingJet20 = data[0].split(',')[0].toString();
          valuedj20 = data[0].split(',')[1].toString();
          //
          dyeingJet21 = data[1].split(',')[0].toString();
          valuedj21 = data[1].split(',')[1].toString();
          //
          dyeingJet22 = data[2].split(',')[0].toString();
          valuedj22 = data[2].split(',')[1].toString();
          //
          dyeingJet23 = data[3].split(',')[0].toString();
          valuedj23 = data[3].split(',')[1].toString();
          listGroup0.add(SocketGroup0(
            date.toString(),
            double.parse(dyeingJet20),
            double.parse(dyeingJet21),
            double.parse(dyeingJet22),
            double.parse(dyeingJet23),
          ));
          // if (dataDy0 != null && dataDy1 != null && dataDy2 != null) {
          //   Timer(Duration(milliseconds: 650), () {
          //     dataDy0 = null;
          //   });
          // }
          Iterable reverse = listGroup0.reversed;
          reverseGroup0 = reverse.toList();
        });
      }
      if (c[0].topic == "/2022/Majalaya/JetDyeing-Group1/temperature") {
        var data = payload.split(';');
        print("DATA DG-1: $data");
        setState(() {
          if (listGroup1.length >= 21) {
            listGroup1.removeAt(0);
          }

          // print(data[0].split(',')[0]);
          // dyeingJet5 = data[1].split(',')[0];
          dyeingJet24 = data[0].split(',')[0].toString();
          valuedj24 = data[0].split(',')[1].toString();
          //
          dyeingJet25 = data[1].split(',')[0].toString();
          valuedj25 = data[1].split(',')[1].toString();
          //
          dyeingJet26 = data[2].split(',')[0].toString();
          valuedj26 = data[1].split(',')[1].toString();
          //
          dyeingJet27 = data[3].split(',')[0].toString();
          valuedj27 = data[1].split(',')[1].toString();
          listGroup1.add(SocketGroup1(
            date.toString(),
            double.parse(dyeingJet24),
            double.parse(dyeingJet25),
            double.parse(dyeingJet26),
            double.parse(dyeingJet27),
          ));
          // if (dataDy0 != null && dataDy1 != null && dataDy2 != null) {
          //   Timer(Duration(milliseconds: 650), () {
          //     dataDy1 = null;
          //   });
          // }
          Iterable reverse = listGroup1.reversed;
          reverseGroup1 = reverse.toList();
        });
      }
      if (c[0].topic == "/2022/Majalaya/JetDyeing-Group2/temperature") {
        var data = payload.split(';');
        print("DATA DG-2: $data");
        setState(() {
          if (listGroup2.length >= 21) {
            listGroup2.removeAt(0);
          }

          // print(data[0].split(',')[0]);
          // dyeingJet5 = data[1].split(',')[0];
          dyeingJet28 = data[0].split(',')[0].toString();
          valuedj28 = data[1].split(',')[1].toString();
          //
          dyeingJet29 = data[0].split(',')[0].toString();
          valuedj29 = data[1].split(',')[1].toString();
          listGroup2.add(SocketGroup2(
            date.toString(),
            double.parse(dyeingJet28),
            double.parse(dyeingJet29),
          ));
          // if (dataDy0 != null && dataDy1 != null && dataDy2 != null) {
          //   Timer(Duration(milliseconds: 650), () {
          //     dataDy2 = null;
          //   });
          // }
          Iterable reverse = listGroup2.reversed;
          reverseGroup2 = reverse.toList();
        });
      }
      setState(() {});
    });
    client.subscribe("/2022/Majalaya/JetDyeing-Group0/temperature", MqttQos.atMostOnce);
    client.subscribe("/2022/Majalaya/JetDyeing-Group1/temperature", MqttQos.atMostOnce);
    client.subscribe("/2022/Majalaya/JetDyeing-Group2/temperature", MqttQos.atMostOnce);
    return client;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthSessionCubit>(context).getRole();
    int random = Random().nextInt(100000);
    setState(() {
      device = "Device_${random}";
    });
    Future.delayed(Duration(seconds: 1));
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text('MIS | Grafik DyeingJet'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PROFILE);
                  },
                  icon: Icon(Icons.more_horiz_rounded)),
            ],
          ),
          drawer: CustomDrawer(),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(top: 2.0, left: 14.0, right: 30),
                      child: SfCartesianChart(
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                        ),
                        title: ChartTitle(text: 'Dyeing Jet Group 0'),
                        primaryXAxis: CategoryAxis(
                          labelPlacement: LabelPlacement.onTicks,
                          visibleMinimum: 0,
                          visibleMaximum: 20,
                          isInversed: true,
                          labelRotation: 20,
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          opposedPosition: true,
                          placeLabelsNearAxisLine: true,
                        ),
                        series: <ChartSeries>[
                          SplineSeries<SocketGroup0, String>(
                            animationDuration: 2000,
                            name: 'Dyeing Jet 20',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reverseGroup0 ?? [],
                            xValueMapper: (SocketGroup0 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup0 sc, _) => sc.dyeingJet1!,
                            markerSettings: MarkerSettings(),
                            color: Color(0xFF533E85),
                          ),
                          SplineSeries<SocketGroup0, String>(
                            animationDuration: 2000,

                            name: 'Dyeing Jet 21',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reverseGroup0 ?? [],
                            xValueMapper: (SocketGroup0 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup0 sc, _) => sc.dyeingJet2!,
                            color: Color(0xFFE21818),
                          ),
                          SplineSeries<SocketGroup0, String>(
                              animationDuration: 2000,
                              name: 'Dyeing Jet 22',
                              width: 1.5,
                              // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                              dataSource: reverseGroup0 ?? [],
                              xValueMapper: (SocketGroup0 sc, _) => sc.angka.toString(),
                              yValueMapper: (SocketGroup0 sc, _) => sc.dyeingJet3!,
                              color: Color(0xFFFFDD83)),
                          SplineSeries<SocketGroup0, String>(
                            animationDuration: 2000,

                            name: 'Dyeing Jet 23',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reverseGroup0 ?? [],
                            xValueMapper: (SocketGroup0 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup0 sc, _) => sc.dyeingJet4!,
                            color: Color(0xFF2E4F4F),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF533E85),
                                  margin: const EdgeInsets.only(bottom: 4, left: 2, right: 2, top: 8),
                                ),
                                Text("Dyeing JET 20", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet20 ?? '', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFFE21818),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 21", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet21 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFFFFDD83),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 22", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet22 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF2E4F4F),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 23", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet23 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // GROUP 1
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(top: 2.0, left: 14.0, right: 30),
                      child: SfCartesianChart(
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                        ),
                        title: ChartTitle(text: 'Dyeing Jet Group 1'),
                        primaryXAxis: CategoryAxis(
                          labelPlacement: LabelPlacement.onTicks,
                          visibleMinimum: 0,
                          visibleMaximum: 20,
                          isInversed: true,
                          labelRotation: 20,
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          opposedPosition: true,
                          placeLabelsNearAxisLine: true,
                        ),
                        series: <ChartSeries>[
                          SplineSeries<SocketGroup1, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 24',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup1 ?? [],
                            xValueMapper: (SocketGroup1 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup1 sc, _) => sc.dyeingJet5,
                            color: Color(0xFFE21818),
                          ),
                          SplineSeries<SocketGroup1, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 25',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup1 ?? [],
                            xValueMapper: (SocketGroup1 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup1 sc, _) => sc.dyeingJet6,
                            color: Color(0xFF8F43EE),
                          ),
                          SplineSeries<SocketGroup1, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 26',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup1 ?? [],
                            xValueMapper: (SocketGroup1 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup1 sc, _) => sc.dyeingJet7,
                            color: Color(0xFF62CDFF),
                          ),
                          SplineSeries<SocketGroup1, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 27',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup1 ?? [],
                            xValueMapper: (SocketGroup1 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup1 sc, _) => sc.dyeingJet8,
                            color: Color(0xFF8D7B68),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFFE21818),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 24", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet24 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF8F43EE),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 25", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet25 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF62CDFF),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 26", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet26 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF8D7B68),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                Text("Dyeing JET 27", style: TextStyle(fontSize: 12)),
                                Text(dyeingJet27 ?? "", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // GROUP 2
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(top: 4.0, left: 14.0, right: 20),
                      child: SfCartesianChart(
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                        ),
                        title: ChartTitle(text: 'Dyeing Jet Group 2'),
                        primaryXAxis: CategoryAxis(
                          labelPlacement: LabelPlacement.onTicks,
                          visibleMinimum: 0,
                          visibleMaximum: 20,
                          isInversed: true,
                          labelRotation: 20,
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          opposedPosition: true,
                          placeLabelsNearAxisLine: true,
                        ),
                        series: <ChartSeries>[
                          SplineSeries<SocketGroup2, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 28',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup2 ?? [],
                            xValueMapper: (SocketGroup2 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup2 sc, _) => sc.dyeingJet9,
                            color: Colors.green[600],
                          ),
                          SplineSeries<SocketGroup2, String>(
                            animationDuration: 1500,
                            name: 'Dyeing Jet 29',
                            width: 1.5,
                            // dataSource: reverseGroup1 == null ? listGroup1 : reverseGroup1,
                            dataSource: reverseGroup2 ?? [],
                            xValueMapper: (SocketGroup2 sc, _) => sc.angka.toString(),
                            yValueMapper: (SocketGroup2 sc, _) => sc.dyeingJet10,
                            color: Colors.pink[600],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 20,
                                color: Colors.green[600],
                                margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                              ),
                              Text("Dyeing JET 28", style: TextStyle(fontSize: 12)),
                              Text(dyeingJet28 ?? "", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 20,
                                color: Colors.pink,
                                margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                              ),
                              Text("Dyeing JET 29", style: TextStyle(fontSize: 12)),
                              Text(dyeingJet29 ?? "", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [MyCopyright()],
                ),
              ),
            ],
          )),
    );
  }
}
