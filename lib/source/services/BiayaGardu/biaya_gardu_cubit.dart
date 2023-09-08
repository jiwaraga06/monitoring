import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/pages/Menu/BiayaGardu/Pdf/biayagarduView.dart';
import 'package:monitoring/source/pages/Menu/LaporanProduksi/content/viewPdf.dart';
import 'package:monitoring/source/repository/repository.dart';
import 'package:path_provider/path_provider.dart';

part 'biaya_gardu_state.dart';

class BiayaGarduCubit extends Cubit<BiayaGarduState> {
  final MyRepository? myRepository;
  BiayaGarduCubit({required this.myRepository}) : super(BiayaGarduInitial());

  void biayagardu(tahun, bulan) async {
    emit(BiayaGarduLoading());
    print("$tahun,$bulan");
    myRepository!.biayaGardu(tahun, bulan).then((value) {
      var json = jsonDecode(value.body);
      print("Biaya gardu: $json");
      print("Biaya gardu: ${value.statusCode}");
      if (value.statusCode == 200) {
        emit(BiayaGarduLoaded(json: json, statusCode: value.statusCode));
      } else {
        emit(BiayaGarduLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }

  void sharePdf(periode, last_date, biaya, context) async {
    var documentdir;
    if (Platform.isAndroid) {
      documentdir = (await getExternalStorageDirectory())!.path;
    } else if (Platform.isIOS) {
      documentdir = (await getApplicationDocumentsDirectory()).path;
    }
    final biayaGardu = "biayaGardu";
    var body = {
      'periode': periode,
      'last_date': last_date,
      'biaya': biaya
    };
    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      PDFBIAYAGARDU.htmlContent(body),
      documentdir,
      biayaGardu,
    );
    print(generatedPdfFile.uri.toFilePath());
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PDFLaporanProduksi()));
    await FlutterShare.shareFile(title: 'Share', text: 'Share document', filePath: generatedPdfFile.uri.toFilePath());
  }
}
