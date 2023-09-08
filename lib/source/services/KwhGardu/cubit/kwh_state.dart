part of 'kwh_cubit.dart';

@immutable
abstract class KwhState {}

class KwhInitial extends KwhState {}

class KwhLoading extends KwhState {}

class KwhLoaded extends KwhState {
  final int? statusCode;
  dynamic json;

  KwhLoaded({this.statusCode, this.json});
}
