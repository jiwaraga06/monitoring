import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monitoring/source/pages/Menu/SessionManager/sessionManager.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/menu_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_dyeing_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_temp_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_laporan_produksi_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_memo_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_session_manager_cubit.dart';
import 'package:monitoring/source/widget/customDialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Color(0XFFFFDD83)),
                  child: Center(
                    child: Image.asset('assets/img/icon.png', height: 120),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
                  },
                  leading: Icon(Icons.home_sharp, size: 30, color: Colors.blue),
                  title: Text('Home', style: TextStyle(fontSize: 16)),
                ),
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
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, MEMO);
                                },
                                leading: Icon(Icons.edit_note, size: 30, color: Colors.teal),
                                title: Text('Memo', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PinMemoCubit>(context).pinMemo(memo);
                                    BlocProvider.of<PinMemoCubit>(context).getPinned();
                                  },
                                  icon: memo == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, SESSION_MANAGER);
                                },
                                leading: Icon(Icons.account_balance_wallet, size: 30, color: Colors.brown),
                                title: Text('Session Manager', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PinSessionManagerCubit>(context).pinSessionManager(sm);
                                    BlocProvider.of<PinSessionManagerCubit>(context).getPinned();
                                  },
                                  icon: sm == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
                            return ListTile(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, BIAYA_GARDU);
                              },
                              leading: Icon(FontAwesomeIcons.dollar, color: Colors.red[600], size: 25),
                              title: Text('Biaya', style: TextStyle(fontSize: 16)),
                              trailing: IconButton(
                                onPressed: () {
                                  BlocProvider.of<MenuBiayaCubit>(context).pinnedBiaya(biaya);
                                  BlocProvider.of<MenuBiayaCubit>(context).getPinned();
                                },
                                icon: biaya == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, GRAFIK_TEMPERATUR);
                                },
                                leading: Icon(FontAwesomeIcons.chartLine, color: Colors.red[600], size: 25),
                                title: Text('Grafik Temperatur', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PinGrafikTempCubit>(context).pinGrafikTemp(grafikTemp);
                                    BlocProvider.of<PinGrafikTempCubit>(context).getPinned();
                                  },
                                  icon: grafikTemp == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, GRAFIK_DYEINGJET);
                                },
                                leading: Icon(FontAwesomeIcons.chartLine, color: Colors.blue[600], size: 25),
                                title: Text('Grafik Dyeing Jet', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PinGrafikDyeingCubit>(context).pinGrafikDyeing(grafikDyeing);
                                    BlocProvider.of<PinGrafikDyeingCubit>(context).getPinned();
                                  },
                                  icon: grafikDyeing == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, LAPORAN_PRODUKSI);
                                },
                                leading: Icon(FontAwesomeIcons.filePdf, color: Colors.grey[600], size: 25),
                                title: Text('Laporan Produksi', style: TextStyle(fontSize: 16)),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PinLaporanProduksiCubit>(context).pinLaporanProduksi(laporanProduksi);
                                    BlocProvider.of<PinLaporanProduksiCubit>(context).getPinned();
                                  },
                                  icon: laporanProduksi == false ? Icon(Icons.push_pin_outlined) : Icon(Icons.push_pin),
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
          ListTile(
            onTap: () {
              MyDialog.dialogInfo(context, "Apakah Anda ingin logout ? ", () {
                BlocProvider.of<AuthSessionCubit>(context).logout(context);
              });
            },
            leading: Icon(FontAwesomeIcons.rightFromBracket, color: Colors.red[700], size: 25),
            title: Text('Logout', style: TextStyle(fontSize: 20, color: Colors.red[600], fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }
}
