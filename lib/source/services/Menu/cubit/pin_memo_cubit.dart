import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pin_memo_state.dart';

class PinMemoCubit extends Cubit<PinMemoState> {
  PinMemoCubit() : super(PinMemoInitial());

  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var memo = pref.getBool('memo');
    if (memo == null) {
      emit(PinMemo(memo: false));
    } else {
      emit(PinMemo(memo: memo));
    }
  }

  void pinMemo(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      pref.setBool('memo', false);
    } else {
      pref.setBool('memo', true);
    }
  }
}
