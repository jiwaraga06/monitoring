import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/menu_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_dyeing_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_temp_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_laporan_produksi_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_memo_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_session_manager_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthSessionCubit>(context).getRole();
    BlocProvider.of<PinMemoCubit>(context).getPinned();
    BlocProvider.of<PinSessionManagerCubit>(context).getPinned();
    BlocProvider.of<MenuBiayaCubit>(context).getPinned();
    BlocProvider.of<PinGrafikTempCubit>(context).getPinned();
    BlocProvider.of<PinGrafikDyeingCubit>(context).getPinned();
    BlocProvider.of<PinLaporanProduksiCubit>(context).getPinned();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: const Text('MIS | Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, PROFILE);
                },
                icon: const Icon(Icons.more_horiz_rounded)),
          ],
        ),
        drawer: const CustomDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/img/logosipatex2.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<AuthSessionCubit, AuthSessionState>(
                    builder: (context, state) {
                      if (state is MenuAkses == false) {
                        return Container();
                      }
                      var role = (state as MenuAkses).role;
                      return Column(
                        children: [
                          if (role.where((e) => e == "memo").toList().isNotEmpty)
                            BlocBuilder<PinMemoCubit, PinMemoState>(
                              builder: (context, state) {
                                if (state is PinMemo == false) {
                                  return Container();
                                }
                                var memo = (state as PinMemo).memo;
                                if (memo == false) return Container();
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, MEMO);
                                  },
                                  leading: const Icon(Icons.edit_note, size: 30, color: Colors.teal),
                                  title: const Text('Memo', style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PinMemoCubit>(context).pinMemo(memo);
                                      BlocProvider.of<PinMemoCubit>(context).getPinned();
                                    },
                                    icon: memo == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                  ),
                                );
                              },
                            ),
                          if (role.where((e) => e == "session_manager").toList().isNotEmpty)
                            BlocBuilder<PinSessionManagerCubit, PinSessionManagerState>(
                              builder: (context, state) {
                                if (state is PinSessionManager == false) {
                                  return Container();
                                }
                                var sm = (state as PinSessionManager).sessionManager;
                                if (sm == false) return Container();
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, SESSION_MANAGER);
                                  },
                                  leading: const Icon(Icons.account_balance_wallet, size: 30, color: Colors.brown),
                                  title: const Text('Session Manager', style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PinSessionManagerCubit>(context).pinSessionManager(sm);
                                      BlocProvider.of<PinSessionManagerCubit>(context).getPinned();
                                    },
                                    icon: sm == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                  ),
                                );
                              },
                            ),
                          // if (role.where((e) => e == "grafik_kwh_gardu").toList().isNotEmpty)
                          //   ListTile(
                          //     onTap: () {
                          //       Navigator.pushReplacementNamed(context, GRAFIK_KWH);
                          //     },
                          //     leading: Icon(FontAwesomeIcons.chartLine, color: Colors.orange[600], size: 25),
                          //     title: Text('Grafik KWH Gardu', style: TextStyle(fontSize: 16)),
                          //   ),
                          if (role.where((e) => e == "potensi_biaya_pln").toList().isNotEmpty)
                            BlocBuilder<MenuBiayaCubit, MenuBiayaState>(builder: (context, state) {
                              if (state is MenuBiaya == false) {
                                return Container();
                              }
                              var biaya = (state as MenuBiaya).biayaGardu;
                              if (biaya == false) return Container();
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, BIAYA_GARDU);
                                },
                                leading: Icon(FontAwesomeIcons.dollar, color: Colors.red[600], size: 25),
                                title: const Text('Biaya', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<MenuBiayaCubit>(context).pinnedBiaya(biaya);
                                    BlocProvider.of<MenuBiayaCubit>(context).getPinned();
                                  },
                                  icon: biaya == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                ),
                              );
                            }),
                          if (role.where((e) => e == "grafik_temperatur_tekanan").toList().isNotEmpty)
                            BlocBuilder<PinGrafikTempCubit, PinGrafikTempState>(
                              builder: (context, state) {
                                if (state is PinGrafikTemp == false) {
                                  return Container();
                                }
                                var grafikTemp = (state as PinGrafikTemp).grafikTemp;
                                if (grafikTemp == false) return Container();
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, GRAFIK_TEMPERATUR);
                                  },
                                  leading: Icon(FontAwesomeIcons.chartLine, color: Colors.red[600], size: 25),
                                  title: const Text('Grafik Temperatur', style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PinGrafikTempCubit>(context).pinGrafikTemp(grafikTemp);
                                      BlocProvider.of<PinGrafikTempCubit>(context).getPinned();
                                    },
                                    icon: grafikTemp == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                  ),
                                );
                              },
                            ),
                          if (role.where((e) => e == "grafik_temperatur_tekanan").toList().isNotEmpty)
                            BlocBuilder<PinGrafikDyeingCubit, PinGrafikDyeingState>(
                              builder: (context, state) {
                                if (state is PinGrafikDyeing == false) {
                                  return Container();
                                }
                                var grafikDyeing = (state as PinGrafikDyeing).grafikDyeing;
                                if (grafikDyeing == false) return Container();
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, GRAFIK_DYEINGJET);
                                  },
                                  leading: Icon(FontAwesomeIcons.chartLine, color: Colors.blue[600], size: 25),
                                  title: const Text('Grafik Dyeing Jet', style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PinGrafikDyeingCubit>(context).pinGrafikDyeing(grafikDyeing);
                                      BlocProvider.of<PinGrafikDyeingCubit>(context).getPinned();
                                    },
                                    icon: grafikDyeing == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                  ),
                                );
                              },
                            ),
                          if (role.where((e) => e == "laporan_produksi").toList().isNotEmpty)
                            BlocBuilder<PinLaporanProduksiCubit, PinLaporanProduksiState>(
                              builder: (context, state) {
                                if (state is PinLaporanProduksi == false) {
                                  return Container();
                                }
                                var laporanProduksi = (state as PinLaporanProduksi).laporanProduksi;
                                if (laporanProduksi == false) return Container();
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, LAPORAN_PRODUKSI);
                                  },
                                  leading: Icon(FontAwesomeIcons.filePdf, color: Colors.grey[600], size: 25),
                                  title: const Text('Laporan Produksi', style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PinLaporanProduksiCubit>(context).pinLaporanProduksi(laporanProduksi);
                                      BlocProvider.of<PinLaporanProduksiCubit>(context).getPinned();
                                    },
                                    icon: laporanProduksi == false ? const Icon(Icons.push_pin_outlined) : const Icon(Icons.push_pin),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const MyCopyright()],
              ),
            ),
          ],
        ));
  }
}
