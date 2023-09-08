import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pin_grafik_dyeing_state.dart';

class PinGrafikDyeingCubit extends Cubit<PinGrafikDyeingState> {
  PinGrafikDyeingCubit() : super(PinGrafikDyeingInitial());
  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var grafikDyeing = pref.getBool('grafikDyeing');
    if (grafikDyeing == null) {
      emit(PinGrafikDyeing(grafikDyeing: false));
    } else {
      emit(PinGrafikDyeing(grafikDyeing: grafikDyeing));
    }
  }

  void pinGrafikDyeing(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      pref.setBool('grafikDyeing', false);
    } else {
      pref.setBool('grafikDyeing', true);
    }
  }
}
