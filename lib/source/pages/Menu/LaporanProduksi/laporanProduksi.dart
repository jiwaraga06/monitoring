import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/LaporanProduksi/cubit/laporan_produksi_cubit.dart';
import 'package:monitoring/source/widget/customButton.dart';
import 'package:monitoring/source/widget/drawer.dart';

class LaporanProduksi extends StatefulWidget {
  const LaporanProduksi({super.key});

  @override
  State<LaporanProduksi> createState() => _LaporanProduksiState();
}

class _LaporanProduksiState extends State<LaporanProduksi> {
  TextEditingController controllerTanggal = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void pickdate(BuildContext context) async {
    final DateTime? result = await showDatePicker(
      context: context,
      firstDate: DateTime(2000, 1, 1),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (result != null) {
      print(result.toString());
      setState(() {
        controllerTanggal = TextEditingController(text: result.toString().split(" ").toList()[0].toString());
      });
    }
  }

  var valueList = "produktifitas dyeing finishing";
  var list = [
    {
      "nama": "produktifitas dyeing finishing",
    },
    {
      "nama": "gangguan dyeing finishing",
    },
    {
      "nama": "perbaikan dyeing",
    },
    {
      "nama": "produktifitas printing",
    },
    {
      "nama": "gangguan printing",
    },
    {
      "nama": "grading",
    },
    {
      "nama": "pengiriman",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Laporan Produksi"),
          ),
          drawer: CustomDrawer(),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            onTap: () {
                              pickdate(context);
                            },
                            readOnly: true,
                            controller: controllerTanggal,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Pilih Tanggal',
                              labelText: 'Pilih Tanggal',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Tanggal tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                        )),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(border: OutlineInputBorder()),
                        value: valueList,
                        hint: Text('Pilih Jenis'),
                        isExpanded: true,
                        items: list
                            .map((e) => DropdownMenuItem(
                                  child: Text(e['nama']!),
                                  value: e['nama']!,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            valueList = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LaporanProduksiCubit>(context).laporanProduksi(controllerTanggal.text, valueList, context);
                          }
                        },
                        text: 'Generate PDF',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
