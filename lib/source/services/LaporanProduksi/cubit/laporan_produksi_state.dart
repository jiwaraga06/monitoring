part of 'laporan_produksi_cubit.dart';

@immutable
abstract class LaporanProduksiState {}

class LaporanProduksiInitial extends LaporanProduksiState {}
class LaporanProduksiPdf extends LaporanProduksiState {
  final String? path;

  LaporanProduksiPdf({this.path});
}
