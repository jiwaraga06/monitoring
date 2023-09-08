import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var nama = pref.getString('nama');
    var root = pref.getString('root');
    var direktorat = pref.getString('direktorat');
    var divisi = pref.getString('divisi');
    var departemen = pref.getString('departemen');
    var bagian = pref.getString('bagian');
    var seksi = pref.getString('seksi');
    var level = pref.getString('level');
    var emp_position = pref.getString('emp_position');
    var data = {
      "email": email,
      "nama": nama,
      "root": root,
      "direktorat": direktorat,
      "divisi": divisi,
      "departemen": departemen,
      "bagian": bagian,
      "seksi": seksi,
      "level": level,
      "emp_position": emp_position,
    };
    print(data);
    emit(ProfileLoaded(json: data));
  }
}
