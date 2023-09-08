part of 'pin_session_manager_cubit.dart';

@immutable
abstract class PinSessionManagerState {}

class PinSessionManagerInitial extends PinSessionManagerState {}
class PinSessionManager extends PinSessionManagerState {
  final bool? sessionManager;

  PinSessionManager({this.sessionManager});
}
