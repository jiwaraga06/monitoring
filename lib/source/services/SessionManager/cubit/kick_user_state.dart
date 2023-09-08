part of 'kick_user_cubit.dart';

@immutable
abstract class KickUserState {}

class KickUserInitial extends KickUserState {}

class KickUserLoading extends KickUserState {}

class KickUserLoaded extends KickUserState {
  final int? statusCode;
  dynamic json;

  KickUserLoaded({this.statusCode, this.json});
}
