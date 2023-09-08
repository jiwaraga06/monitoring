import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pin_grafik_temp_state.dart';

class PinGrafikTempCubit extends Cubit<PinGrafikTempState> {
  PinGrafikTempCubit() : super(PinGrafikTempInitial());
  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var grafikTemp = pref.getBool('grafikTemp');
    if (grafikTemp == null) {
      emit(PinGrafikTemp(grafikTemp: false));
    } else {
      emit(PinGrafikTemp(grafikTemp: grafikTemp));
    }
  }

  void pinGrafikTemp(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      pref.setBool('grafikTemp', false);
    } else {
      pref.setBool('grafikTemp', true);
    }
  }
}
