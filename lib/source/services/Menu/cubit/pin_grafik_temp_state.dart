part of 'pin_grafik_temp_cubit.dart';

@immutable
abstract class PinGrafikTempState {}

class PinGrafikTempInitial extends PinGrafikTempState {}
class PinGrafikTemp extends PinGrafikTempState {
  final bool? grafikTemp;

  PinGrafikTemp({this.grafikTemp});
}
