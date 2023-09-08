part of 'sessionmanager_cubit.dart';

@immutable
abstract class SessionmanagerState {}

class SessionmanagerInitial extends SessionmanagerState {}

class SessionmanagerLoading extends SessionmanagerState {}

class SessionmanagerLoaded extends SessionmanagerState {
  final int? statusCode;
  dynamic json;

  SessionmanagerLoaded({this.statusCode, this.json});
}
