part of 'menu_cubit.dart';

@immutable
abstract class MenuBiayaState {}

class MenuBiayaInitial extends MenuBiayaState {}

class MenuBiaya extends MenuBiayaState {
  final bool? biayaGardu;

  MenuBiaya({this.biayaGardu});
}
