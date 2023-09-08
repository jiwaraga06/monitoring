import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/repository/repository.dart';
part 'kwh_state.dart';

class KwhCubit extends Cubit<KwhState> {
  final MyRepository? myRepository;
  KwhCubit({required this.myRepository}) : super(KwhInitial());

  void getKwh(bulan, tahun) async {
    emit(KwhLoading());
    var body = {
      "bulan": "$bulan",
      "tahun": "$tahun",
    };
    print(body);
    myRepository!.kwhGardu(jsonEncode(body)).then((value) {
      print('kwh: ${value.body}');
      print('kwh: ${value.statusCode}');
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        emit(KwhLoaded(json: json, statusCode: statusCode));
      } else {
        emit(KwhLoaded(json: json, statusCode: statusCode));
      }
    });
  }
}
