import 'package:get/get.dart';
import 'package:monitoring/source/pages/Auth/login.dart';
import 'package:monitoring/source/pages/Auth/splashScreen.dart';
import 'package:monitoring/source/pages/Menu/BiayaGardu/biayagardu.dart';
import 'package:monitoring/source/pages/Menu/GrafikDyeingJet/grafikDyeingJet.dart';
import 'package:monitoring/source/pages/Menu/GrafikKwh/grafikKwh.dart';
import 'package:monitoring/source/pages/Menu/GrafikTemperatur/grafikTemperatur.dart';
import 'package:monitoring/source/pages/Menu/Home/home.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/laporanProduksi.dart';
import 'package:monitoring/source/pages/Menu/Memo/addMemo.dart';
import 'package:monitoring/source/pages/Menu/Memo/editMemo.dart';
import 'package:monitoring/source/pages/Menu/Memo/memo.dart';
import 'package:monitoring/source/pages/Menu/Memo/viewMemo.dart';
import 'package:monitoring/source/pages/Menu/Profile/profile.dart';
import 'package:monitoring/source/pages/Menu/SessionManager/sessionManager.dart';
import 'package:monitoring/source/router/string.dart';

class RouterNavigation {
  static final pages = [
    GetPage(
      name: SPLASH,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: LOGIN,
      page: () => Login(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: HOME,
      page: () => Home(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: PROFILE,
      page: () => Profile(),
      transition: Transition.rightToLeft,
    ),
    // MEMO
    GetPage(
      name: MEMO,
      page: () => Memo(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: ADD_MEMO,
      page: () => AddMemo(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: EDIT_MEMO,
      page: () => EditMemo(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: VIEW_MEMO,
      page: () => ViewMemo(),
      transition: Transition.rightToLeft,
    ),
//
    GetPage(
      name: SESSION_MANAGER,
      page: () => SessionManager(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: GRAFIK_KWH,
      page: () => GrafikKwh(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: BIAYA_GARDU,
      page: () => BiayaGardu(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: GRAFIK_DYEINGJET,
      page: () => GrafikDyeingJet(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: GRAFIK_TEMPERATUR,
      page: () => GrafikTemperatur(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: LAPORAN_PRODUKSI,
      page: () => LaporanProduksi(),
      transition: Transition.rightToLeft,
    ),
  ];
}
