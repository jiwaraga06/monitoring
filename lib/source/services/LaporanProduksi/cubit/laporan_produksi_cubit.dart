import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/GangguanDF/gangguanDFview.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/GangguanPrinting/ganggaunPrintingView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/Grading/gradingView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/Pengiriman/pengirimanView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/PerbaikanDyeing/perbaikanDyeingView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/ProduktifitasDF/produktifitasDFview.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/ProduktifitasPrinting/produktifitasPrintingView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/viewPdf.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'laporan_produksi_state.dart';

class LaporanProduksiCubit extends Cubit<LaporanProduksiState> {
  final MyRepository? myRepository;
  LaporanProduksiCubit({required this.myRepository}) : super(LaporanProduksiInitial());

  var listgangguandf = [];
  Future<void> laporanProduksi(tglProduksi, value, context) async {
    var datepick = DateFormat('EEEE / dd-MM-yyyy').format(DateTime.parse("$tglProduksi"));
    var dayCetak = DateFormat('EEEE / dd-MM-yyyy').format(DateTime.now());
    var documentdir;
    if (Platform.isAndroid) {
      documentdir = (await getExternalStorageDirectory())!.path;
    } else if (Platform.isIOS) {
      documentdir = (await getApplicationDocumentsDirectory()).path;
    }
    Directory path = Directory('/data/user/0/Download');
    final laporanProduksi = "LaporanProduksi";
    // final targetpath = path;
    // final targetpath = '/storage/emulated/0/Download';
    // File file = File("/storage/emulated/0/Download/LaporanProduksi-pdf.html");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nama = pref.getString('nama');
    EasyLoading.show();

    print(nama);
    if (value == "produktifitas dyeing finishing") {
      myRepository!.laporantProduksi(tglProduksi, "Y", "N", "N", "N", "N", "N", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, 'dyeing': json['produktifitas_dyeing_finishing']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          PRODUKTIFITASDFVIEW.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "gangguan dyeing finishing") {
      myRepository!.laporantProduksi(tglProduksi, "N", "Y", "N", "N", "N", "N", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, "gangguan": json['gangguan_dyeing_finishing']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          GANGGUANDFVIEW.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "perbaikan dyeing") {
      myRepository!.laporantProduksi(tglProduksi, "N", "N", "Y", "N", "N", "N", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, 'perbaikan': json['perbaikan_dyeing']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          PERBAIKAN_DYEING.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "produktifitas printing") {
      myRepository!.laporantProduksi(tglProduksi, "N", "N", "N", "Y", "N", "N", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, 'produktifitas_printing': json['produktifitas_printing']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          ProduktifitasPrinting.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "gangguan printing") {
      myRepository!.laporantProduksi(tglProduksi, "N", "N", "N", "N", "Y", "N", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, 'gangguan_printing': json['gangguan_printing']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          GangguanPrinting.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "grading") {
      myRepository!.laporantProduksi(tglProduksi, "N", "N", "N", "N", "N", "Y", "N").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: ${value.body}");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        var body = {'tglProduksi': datepick, 'tglCetak': dayCetak, 'nama': nama, 'grading': json['grading']};
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          Grading.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    } else if (value == "pengiriman") {
      myRepository!.laporantProduksi(tglProduksi, "N", "N", "N", "N", "N", "N", "Y").then((value) async {
        var json = jsonDecode(value.body);
        print("JSON: $json");
        print("JSON: ${value.statusCode}");
        if (json != null) {
          EasyLoading.dismiss();
        }
        // print(json['pengiriman']['STOCK']);
        var body = {
          'tglProduksi': datepick,
          'tglCetak': dayCetak,
          'nama': nama,
          'pengiriman': json['pengiriman'],
        };
        final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          PENGIRIMANVIEW.htmlContent(body),
          documentdir,
          laporanProduksi,
        );
        print(generatedPdfFile.uri.toFilePath());
        emit(LaporanProduksiPdf(path: generatedPdfFile.uri.toFilePath()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
      });
    }
  }

  void sharePdf(file) async {
    await FlutterShare.shareFile(title: 'Share', text: 'Share document', filePath: file.path);
  }
}
