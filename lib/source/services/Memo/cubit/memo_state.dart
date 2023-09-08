part of 'memo_cubit.dart';

@immutable
abstract class MemoState {}

class MemoInitial extends MemoState {}

class MemoLoading extends MemoState {}

class MemoLoaded extends MemoState {
  final int? statusCode;
  dynamic json;

  MemoLoaded({this.statusCode, this.json});
}

class AddMemoLoading extends MemoState {}

class AddMemoLoaded extends MemoState {
  final int? statusCode;
  dynamic json;

  AddMemoLoaded({this.statusCode, this.json});
}

class UpdateMemoLoading extends MemoState {}

class UpdateMemoLoaded extends MemoState {
  final int? statusCode;
  dynamic json;

  UpdateMemoLoaded({this.statusCode, this.json});
}

