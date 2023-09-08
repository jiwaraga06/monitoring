part of 'auth_session_cubit.dart';

@immutable
abstract class AuthSessionState {}

class AuthSessionInitial extends AuthSessionState {}

class LoginLoading extends AuthSessionState {}

class LoginLoaded extends AuthSessionState {
  final int? statusCode;
  dynamic json;

  LoginLoaded({this.statusCode, this.json});
}

class MenuAkses extends AuthSessionState {
  dynamic role;
  MenuAkses({this.role});
}
