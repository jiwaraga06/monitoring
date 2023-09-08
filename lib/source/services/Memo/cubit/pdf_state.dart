part of 'pdf_cubit.dart';

@immutable
abstract class PdfState {}

class PdfInitial extends PdfState {}

class PdfPath extends PdfState {
  final String? path;

  PdfPath({this.path});
}
