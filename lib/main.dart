import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monitoring/source/network/network.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:monitoring/source/router/router.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/services/Auth/cubit/profile_cubit.dart';
import 'package:monitoring/source/services/BiayaGardu/biaya_gardu_cubit.dart';
import 'package:monitoring/source/services/KwhGardu/cubit/kwh_cubit.dart';
import 'package:monitoring/source/services/LaporanProduksi/cubit/laporan_produksi_cubit.dart';
import 'package:monitoring/source/services/Memo/cubit/memo_cubit.dart';
import 'package:monitoring/source/services/Memo/cubit/pdf_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/menu_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_dyeing_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_grafik_temp_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_laporan_produksi_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_memo_cubit.dart';
import 'package:monitoring/source/services/Menu/cubit/pin_session_manager_cubit.dart';
import 'package:monitoring/source/services/SessionManager/cubit/kick_user_cubit.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'source/services/SessionManager/cubit/sessionmanager_cubit.dart';

void main() async {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});

  @override
  Widget build(BuildContext context) {
    ThemeData _buildTheme(brightness) {
      var baseTheme = ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      );
      return baseTheme.copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
        textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthSessionCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => MemoCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => PdfCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => SessionmanagerCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => KickUserCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => KwhCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => BiayaGarduCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => LaporanProduksiCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => MenuBiayaCubit()),
        BlocProvider(create: (context) => PinMemoCubit()),
        BlocProvider(create: (context) => PinSessionManagerCubit()),
        BlocProvider(create: (context) => PinGrafikTempCubit()),
        BlocProvider(create: (context) => PinGrafikDyeingCubit()),
        BlocProvider(create: (context) => PinLaporanProduksiCubit()),
      ],
      child: GetMaterialApp(
        theme: _buildTheme(Brightness.light),
        debugShowCheckedModeBanner: false,
        initialRoute: SPLASH,
        getPages: RouterNavigation.pages,
        builder: EasyLoading.init(),
      ),
    );
  }
}
