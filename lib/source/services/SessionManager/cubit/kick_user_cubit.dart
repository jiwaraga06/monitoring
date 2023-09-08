import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'kick_user_state.dart';

class KickUserCubit extends Cubit<KickUserState> {
  final MyRepository? myRepository;
  KickUserCubit({required this.myRepository}) : super(KickUserInitial());

  void kickUser(emailUser, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    print(emailUser == email);
    emit(KickUserLoading());
    var body = {"email": emailUser};
    print(body);
    myRepository!.kickUser(body).then((value) {
      var json = jsonDecode(value.body);
      print(json);
      if (value.statusCode == 200) {
        if (emailUser == email) {
          emit(KickUserLoaded(json: json, statusCode: value.statusCode));
          Timer(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
          });
        } else {
          emit(KickUserLoaded(json: json, statusCode: value.statusCode));
        }
      }
    });
  }
}
