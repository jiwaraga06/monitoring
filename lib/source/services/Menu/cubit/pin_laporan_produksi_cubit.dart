import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pin_laporan_produksi_state.dart';

class PinLaporanProduksiCubit extends Cubit<PinLaporanProduksiState> {
  PinLaporanProduksiCubit() : super(PinLaporanProduksiInitial());
  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var laporanProduksi = pref.getBool('laporanProduksi');
    if (laporanProduksi == null) {
      emit(PinLaporanProduksi(laporanProduksi: false));
    } else {
      emit(PinLaporanProduksi(laporanProduksi: laporanProduksi));
    }
  }

  void pinLaporanProduksi(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      pref.setBool('laporanProduksi', false);
    } else {
      pref.setBool('laporanProduksi', true);
    }
  }
}
