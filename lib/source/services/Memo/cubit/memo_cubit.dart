import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'memo_state.dart';

class MemoCubit extends Cubit<MemoState> {
  final MyRepository? myRepository;
  MemoCubit({required this.myRepository}) : super(MemoInitial());

  void getMemo(page) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    emit(MemoLoading());
    myRepository!.getMemo(email, page, 1).then((value) {
      print('Memo: ${value.body}');
      print('Memo: ${value.statusCode}');
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      emit(MemoLoaded(statusCode: statusCode, json: json));
    });
  }

  void addMemo(nosurat, perihal, kepada, isi) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    emit(AddMemoLoading());
    var body = {
      "no_surat": "$nosurat",
      "perihal": "$perihal",
      "kepada": "$kepada",
      "isi": "${isi.toString()}",
      "penutup": null,
      "email": "$email",
    };
    print(body);
    myRepository!.addMemo(jsonEncode(body)).then((value) {
      var statusCode = value.statusCode;
      print('Memo: ${value.body}');
      print('Memo: $statusCode');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(AddMemoLoaded(statusCode: statusCode, json: json));
      } else {
        emit(AddMemoLoaded(statusCode: statusCode, json: {'message': '${value.body}'}));
      }
    });
  }

  void updateMemo(memoid, nosurat, perihal, kepada, isi) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    emit(UpdateMemoLoading());
    var body = {
      "memo_id": "$memoid",
      "no_surat": "$nosurat",
      "perihal": "$perihal",
      "kepada": "$kepada",
      "isi": "$isi",
      "penutup": null,
      "email": "$email",
    };
    print(body);
    myRepository!.updateMemo(jsonEncode(body)).then((value) {
      print('Memo: ${value.body}');
      print('Memo: ${value.statusCode}');
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        emit(UpdateMemoLoaded(statusCode: statusCode, json: json));
      } else {
        emit(UpdateMemoLoaded(statusCode: statusCode, json: {'message': '${value.body}'}));
      }
    });
  }
}
