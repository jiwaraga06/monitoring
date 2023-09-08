part of 'pin_grafik_dyeing_cubit.dart';

@immutable
abstract class PinGrafikDyeingState {}

class PinGrafikDyeingInitial extends PinGrafikDyeingState {}
class PinGrafikDyeing extends PinGrafikDyeingState {
  final bool? grafikDyeing;

  PinGrafikDyeing({this.grafikDyeing});
}
