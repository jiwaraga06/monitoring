import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  final MyRepository? myRepository;
  AuthSessionCubit({required this.myRepository}) : super(AuthSessionInitial());

  void splash(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var body = {"email": "$email"};
    print(body);
    myRepository!.checkSession(body).then((value) {
      var statusCode = value.statusCode;
      print('Session: ${value.body}');
      print('Session: ${email}');
      if (statusCode == 200) {
        var json = jsonDecode(value.body);
        if (json == true && email != null) {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
          });
        } else {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
          });
        }
        // Timer(const Duration(seconds: 1), () {
        // });
      }
    });
  }

  void checkSession(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var body = {'email': "$email"};
    myRepository!.checkSession(body).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        if (json == true) {
          Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
        }
      }
    });
  }

  void logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var body = {'email': "$email"};
    myRepository!.logout(jsonEncode(body)).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
        pref.clear();
      }
    });
  }

  void getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var menu_akses = pref.getString('menu_akses');
    emit(MenuAkses(role: jsonDecode(menu_akses.toString())));
  }

  void login(email, password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var device_uuid;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      print(iosDeviceInfo.identifierForVendor);
      device_uuid = iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo.id);
      device_uuid = androidDeviceInfo.id;
    }
    var body = {
      "email": "$email",
      "password": "$password",
      "uuid": "$device_uuid",
    };
    print(body);
    emit(LoginLoading());
    myRepository!.login(body).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('LOGIN: $json');
      if (statusCode == 200) {
        pref.setString('email', json['email'].toString());
        pref.setString('nama', json['nama'].toString());
        pref.setString('root', json['root'].toString());
        pref.setString('direktorat', json['direktorat'].toString());
        pref.setString('divisi', json['divisi'].toString());
        pref.setString('departemen', json['departemen'].toString());
        pref.setString('bagian', json['bagian'].toString());
        pref.setString('seksi', json['seksi'].toString());
        pref.setString('level', json['level'].toString());
        pref.setString('emp_position', json['emp_position'].toString());
        pref.setString('menu_akses', jsonEncode(json['menu_akses']));
        emit(LoginLoaded(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(LoginLoaded(statusCode: statusCode, json: {"message": json}));
      } else {
        emit(LoginLoaded(statusCode: statusCode, json: json));
      }
    });
  }
}
