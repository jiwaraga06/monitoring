import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/drawer.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dyeing2 {
  String? angka;
  double? tekananUap;
  double? inlet;

  Dyeing2(this.angka, this.tekananUap, this.inlet);
  @override
  String toString() {
    return '{angka:$angka, dyeing2a: $tekananUap, inlet: $inlet}';
  }
}

class Temperatur {
  String? angka;
  double? inlet;
  double? outlet;
  double? delta;

  Temperatur(this.angka, this.inlet, this.outlet, this.delta);
  @override
  String toString() {
    return '{angka:$angka, inlet: $inlet, outlet: $outlet, delta: $delta}';
  }
}
//222.00;195.00;27.00
//inlet, outlet, delta
// inlet

class GrafikTemperatur extends StatefulWidget {
  const GrafikTemperatur({super.key});

  @override
  State<GrafikTemperatur> createState() => _GrafikTemperaturState();
}

class _GrafikTemperaturState extends State<GrafikTemperatur> {
  List<Dyeing2> listDyeing2 = [];
  List<Temperatur> listTemp = [];
  String device = "";
  String gabungNilai = " ";
  var reverseTekanan, reversePressure;
  var tekananUap, inletUap;
  var inlet, outlet, delta;
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
      if (c[0].topic == "/2022/Majalaya/Dyeing2/temperature_pressure") {
        var data = payload.split(';');
        print("DATA Dyeing2: $data");
        setState(() {
          if (listDyeing2.length >= 21) {
            listDyeing2.removeAt(0);
          }
          tekananUap = data[0].split(',')[0].toString();
          inletUap = data[1].split(',')[0].toString();
          listDyeing2.add(Dyeing2(
            date.toString(),
            double.parse(tekananUap),
            double.parse(inletUap),
          ));

          Iterable reverse = listDyeing2.reversed;
          reverseTekanan = reverse.toList();
        });
      }
      if (c[0].topic == "/2022/Majalaya/Printing2/temperature") {
        var data = payload.split(';');
        print("DATA Temperatur: $data");
        setState(() {
          if (listTemp.length >= 21) {
            listTemp.removeAt(0);
          }
          inlet = data[0].toString();
          outlet = data[1].toString();
          delta = data[2].toString();
          listTemp.add(Temperatur(
            date.toString(),
            double.parse(inlet),
            double.parse(outlet),
            double.parse(delta),
          ));

          Iterable reverse = listTemp.reversed;
          reversePressure = reverse.toList();
        });
      }
      if (c[0].topic == "/2022/Majalaya/produksi/display1/TekananUapDF") {
        var data = payload;
        setState(() {
          gabungNilai = data;
        });
        print("DATA DISPLAY: $data");
      }
      setState(() {});
    });
    client.subscribe("/2022/Majalaya/Printing2/temperature", MqttQos.atMostOnce);
    client.subscribe("/2022/Majalaya/Dyeing2/temperature_pressure", MqttQos.atMostOnce);
    client.subscribe("/2022/Majalaya/produksi/display1/TekananUapDF", MqttQos.atMostOnce);
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
            title: Text('MIS | Grafik Temperatur'),
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
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth <= 600) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 320,
                                      margin: const EdgeInsets.only(top: 9.0, left: 14.0, right: 40),
                                      child: SfCartesianChart(
                                        title: ChartTitle(text: 'Tekanan Uap'),
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
                                          SplineSeries<Dyeing2, String>(
                                            animationDuration: 1500,
                                            name: 'Tekanan Uap',
                                            width: 1.5,
                                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                                            dataSource: reverseTekanan ?? [],
                                            xValueMapper: (Dyeing2 sc, _) => sc.angka.toString(),
                                            yValueMapper: (Dyeing2 sc, _) => sc.tekananUap,
                                            markerSettings: MarkerSettings(),
                                            color: Color(0xFF533E85),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 320,
                                      margin: const EdgeInsets.only(top: 9.0, left: 14.0, right: 40),
                                      child: SfCartesianChart(
                                        title: ChartTitle(text: 'Inlet'),
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
                                          SplineSeries<Dyeing2, String>(
                                            animationDuration: 1500,
                                            name: 'Inlet',
                                            width: 1.5,
                                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                                            dataSource: reverseTekanan ?? [],
                                            xValueMapper: (Dyeing2 sc, _) => sc.angka.toString(),
                                            yValueMapper: (Dyeing2 sc, _) => sc.inlet,
                                            markerSettings: MarkerSettings(),
                                            color: Color(0xFF27E1C1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 20,
                                            color: Color(0xFF533E85),
                                            margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                          ),
                                          const Text("Tekanan Uap", style: TextStyle(fontSize: 16)),
                                          Text(tekananUap ?? "", style: TextStyle(fontSize: 16)),
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
                                            color: Color(0xFF27E1C1),
                                            margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                          ),
                                          const Text("Inlet", style: TextStyle(fontSize: 16)),
                                          Text(inletUap ?? "", style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                height: 320,
                                margin: const EdgeInsets.only(top: 9.0, left: 14.0, right: 40),
                                child: SfCartesianChart(
                                  crosshairBehavior: CrosshairBehavior(
                                    enable: true,
                                    activationMode: ActivationMode.singleTap,
                                  ),
                                  title: ChartTitle(text: 'Tekanan Uap'),
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
                                    SplineSeries<Dyeing2, String>(
                                      animationDuration: 1500,
                                      name: 'Tekanan Uap',
                                      width: 1.5,
                                      // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                                      dataSource: reverseTekanan ?? [],
                                      xValueMapper: (Dyeing2 sc, _) => sc.angka.toString(),
                                      yValueMapper: (Dyeing2 sc, _) => sc.tekananUap,
                                      markerSettings: MarkerSettings(),
                                      color: Color(0xFF533E85),
                                    ),
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
                                      color: Color(0xFF533E85),
                                      margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                    ),
                                    const Text("Tekanan Uap", style: TextStyle(fontSize: 16)),
                                    Text(tekananUap ?? "", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Container(
                                height: 320,
                                margin: const EdgeInsets.only(top: 9.0, left: 14.0, right: 40),
                                child: SfCartesianChart(
                                  crosshairBehavior: CrosshairBehavior(
                                    enable: true,
                                    activationMode: ActivationMode.singleTap,
                                  ),
                                  title: ChartTitle(text: 'Inlet'),
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
                                    SplineSeries<Dyeing2, String>(
                                      animationDuration: 1500,
                                      name: 'Inlet',
                                      width: 1.5,
                                      // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                                      dataSource: reverseTekanan ?? [],
                                      xValueMapper: (Dyeing2 sc, _) => sc.angka.toString(),
                                      yValueMapper: (Dyeing2 sc, _) => sc.inlet,
                                      markerSettings: MarkerSettings(),
                                      color: Color(0xFF27E1C1),
                                    ),
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
                                      color: Color(0xFF27E1C1),
                                      margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                    ),
                                    const Text("Inlet", style: TextStyle(fontSize: 16)),
                                    Text(inletUap ?? "", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    Container(
                      height: 320,
                      margin: const EdgeInsets.only(top: 9.0, left: 14.0, right: 40),
                      child: SfCartesianChart(
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                        ),
                        title: ChartTitle(text: 'Tekanan Uap'),
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
                          SplineSeries<Temperatur, String>(
                            animationDuration: 1500,
                            name: 'Inlet',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reversePressure ?? [],
                            xValueMapper: (Temperatur sc, _) => sc.angka.toString(),
                            yValueMapper: (Temperatur sc, _) => sc.inlet,
                            markerSettings: MarkerSettings(),
                            color: Color(0xFF9A208C),
                          ),
                          SplineSeries<Temperatur, String>(
                            animationDuration: 1500,
                            name: 'Outlet',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reversePressure ?? [],
                            xValueMapper: (Temperatur sc, _) => sc.angka.toString(),
                            yValueMapper: (Temperatur sc, _) => sc.outlet,
                            markerSettings: MarkerSettings(),
                            color: Color(0xFFFC2947),
                          ),
                          SplineSeries<Temperatur, String>(
                            animationDuration: 1500,
                            name: 'Delta',
                            width: 1.5,
                            // dataSource: reverseGroup0 == null ? listGroup0 : reverseGroup0,
                            dataSource: reversePressure ?? [],
                            xValueMapper: (Temperatur sc, _) => sc.angka.toString(),
                            yValueMapper: (Temperatur sc, _) => sc.delta,
                            markerSettings: MarkerSettings(),
                            color: Color(0xFF94AF9F),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 20,
                                  color: Color(0xFF9A208C),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                const Text("Inlet", style: TextStyle(fontSize: 16)),
                                Text(inlet ?? "", style: TextStyle(fontSize: 16)),
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
                                  color: Color(0xFFFC2947),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                const Text("Outlet", style: TextStyle(fontSize: 16)),
                                Text(outlet ?? "", style: TextStyle(fontSize: 16)),
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
                                  color: Color(0xFF94AF9F),
                                  margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                                ),
                                const Text("Delta", style: TextStyle(fontSize: 16)),
                                Text(delta ?? "", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.grey[850],
                      height: 40,
                      child: Marquee(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // accelerationDuration: Duration(milliseconds: 500),
                        blankSpace: 50.0,
                        text: "$gabungNilai",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    MyCopyright(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
