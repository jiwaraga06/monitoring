import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'menu_state.dart';

class MenuBiayaCubit extends Cubit<MenuBiayaState> {
  MenuBiayaCubit() : super(MenuBiayaInitial());

  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var biayaGardu = pref.getBool('biayaGardu');
    if (biayaGardu == null) {
      emit(MenuBiaya(biayaGardu: false));
    } else {
      emit(MenuBiaya(biayaGardu: biayaGardu));
    }
  }

  void pinnedBiaya(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print(value);
    if (value == true) {
      pref.setBool('biayaGardu', false);
    } else {
      pref.setBool('biayaGardu', true);
    }
  }
}
