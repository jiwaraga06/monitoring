import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pin_session_manager_state.dart';

class PinSessionManagerCubit extends Cubit<PinSessionManagerState> {
  PinSessionManagerCubit() : super(PinSessionManagerInitial());
  void getPinned() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var sessionManager = pref.getBool('sessionManager');
    if (sessionManager == null) {
      emit(PinSessionManager(sessionManager: false));
    } else {
      emit(PinSessionManager(sessionManager: sessionManager));
    }
  }

  void pinSessionManager(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      pref.setBool('sessionManager', false);
    } else {
      pref.setBool('sessionManager', true);
    }
  }
}
