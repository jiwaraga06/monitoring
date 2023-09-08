part of 'biaya_gardu_cubit.dart';

@immutable
abstract class BiayaGarduState {}

class BiayaGarduInitial extends BiayaGarduState {}

class BiayaGarduLoading extends BiayaGarduState {}

class BiayaGarduLoaded extends BiayaGarduState {
  final int? statusCode;
  dynamic json;

  BiayaGarduLoaded({this.statusCode, this.json});
}
