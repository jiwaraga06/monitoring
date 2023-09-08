part of 'pin_laporan_produksi_cubit.dart';

@immutable
abstract class PinLaporanProduksiState {}

class PinLaporanProduksiInitial extends PinLaporanProduksiState {}

class PinLaporanProduksi extends PinLaporanProduksiState {
  final bool? laporanProduksi;

  PinLaporanProduksi({this.laporanProduksi});
}
