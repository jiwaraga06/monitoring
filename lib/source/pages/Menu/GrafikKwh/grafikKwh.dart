import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/services/KwhGardu/cubit/kwh_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/customFormField.dart';
import 'package:monitoring/source/widget/drawer.dart';
import 'package:month_year_picker/month_year_picker.dart';

class GrafikKwh extends StatefulWidget {
  const GrafikKwh({super.key});

  @override
  State<GrafikKwh> createState() => _GrafikKwhState();
}

class _GrafikKwhState extends State<GrafikKwh> {
  TextEditingController controllerTahun = TextEditingController();
  String periode = "";
  Future<void> _onPressed({required BuildContext context}) async {
    final localeObj = Locale("id");
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: localeObj,
    );
    print(selected);
    if (selected != null) {
      setState(() {
        var date = DateFormat('MMM ,yyyy').format(DateTime.parse(selected.toString().split(' ')[0]));
        periode = date.toString();
        controllerTahun = TextEditingController(text: date.toString());
        BlocProvider.of<KwhCubit>(context).getKwh(selected.month, selected.year);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthSessionCubit>(context).getRole();
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
            title: Text('MIS | Grafik Kwh Gardu'),
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
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onTap: () {
                            _onPressed(context: context);
                          },
                          readOnly: true,
                          autofocus: true,
                          controller: controllerTahun,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '',
                            prefixText: 'Tahun & Bulan : ',
                          ),
                        )),
                    const SizedBox(height: 12),
                    BlocBuilder<KwhCubit, KwhState>(
                      builder: (context, state) {
                        if (state is KwhLoading) {
                          EasyLoading.show();
                        }
                        if (state is KwhLoaded == false) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 1.3,
                                spreadRadius: 1.3,
                                offset: Offset(1, 2),
                              ),
                            ]),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder.all(
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    columns: const [
                                      DataColumn(label: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Nilai Rupiah/Kwh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Aktual KWh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Aktual Rupiah', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Forecast Kwh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Forecast Rupiah', style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: const [
                                      DataRow(
                                        cells: [
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        EasyLoading.dismiss();
                        var json = (state as KwhLoaded).json;
                        var statusCode = (state as KwhLoaded).statusCode;

                        if (statusCode != 200) {
                          return Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(json.toString()),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 1.3,
                                spreadRadius: 1.3,
                                offset: Offset(1, 2),
                              ),
                            ]),
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Text("${json['title']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 30),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    showBottomBorder: true,
                                    border: TableBorder.all(
                                      color: Colors.grey,
                                      width: 1.5,
                                      style: BorderStyle.solid,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey[200]),
                                    columns: const [
                                      DataColumn(label: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Nilai Rupiah/Kwh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Aktual KWh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Aktual Rupiah', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Forecast Kwh', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Total Forecast Rupiah', style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: [
                                          DataCell(Text('WBP')),
                                          DataCell(Text('Rp. ${json['perkwhwbp'].toString()}')),
                                          DataCell(Text('${json['grandtotalkwhaktualwbp'].toString()}')),
                                          DataCell(Text('Rp. ${json['grandtotalrpaktualwbp'].toString()}')),
                                          DataCell(Text('${json['grandtotalkwhforecastwbp'].toString()}')),
                                          DataCell(Text('Rp. ${json['grandtotalrpforecastwbp'].toString()}')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(Text('LWBP')),
                                          DataCell(Text('Rp. ${json['perkwhwbp'].toString()}')),
                                          DataCell(Text('${json['grandtotalkwhaktualwbp'].toString()}')),
                                          DataCell(Text('Rp. ${json['grandtotalrpaktualwbp'].toString()}')),
                                          DataCell(Text('${json['grandtotalkwhforecastwbp'].toString()}')),
                                          DataCell(Text('Rp. ${json['grandtotalrpforecastwbp'].toString()}')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(Text('')),
                                          DataCell(Text('')),
                                          DataCell(Text('${json['grandtotalkwhaktualwbp'] + json['grandtotalkwhaktuallwbp']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('Rp. ${json['grandtotalrpaktualwbp'] + json['grandtotalrpaktuallwbp']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('${json['grandtotalkwhforecastwbp'] + json['grandtotalrpaktuallwbp']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('Rp. ${json['grandtotalrpforecastwbp'] + json['grandtotalrpforecastlwbp']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          );
                        }
                      },
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
