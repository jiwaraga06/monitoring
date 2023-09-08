import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/repository/repository.dart';

part 'sessionmanager_state.dart';

class SessionmanagerCubit extends Cubit<SessionmanagerState> {
  final MyRepository? myRepository;
  SessionmanagerCubit({required this.myRepository}) : super(SessionmanagerInitial());

  void getUserActive() async {
    emit(SessionmanagerLoading());
    myRepository!.getUserActive().then((value) {
      print('USER: ${value.body}');
      print('USER: ${value.statusCode}');
      var json = jsonDecode(value.body);
      emit(SessionmanagerLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
