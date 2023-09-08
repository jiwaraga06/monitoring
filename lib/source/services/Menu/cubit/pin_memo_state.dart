part of 'pin_memo_cubit.dart';

@immutable
abstract class PinMemoState {}

class PinMemoInitial extends PinMemoState {}
class PinMemo extends PinMemoState {
  final bool? memo;

  PinMemo({this.memo});
}
