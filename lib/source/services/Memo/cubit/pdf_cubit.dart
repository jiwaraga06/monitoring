import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:meta/meta.dart';
import 'package:monitoring/source/pages/Menu/Memo/memoPdf.dart';
import 'package:path_provider/path_provider.dart';
part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  PdfCubit() : super(PdfInitial());

  Future<File> createFileOfPdfUrl(memoid, context) async {
    final url = "https://satu.sipatex.co.id:2087/api/v1/mobile-app/memo-pdf/$memoid/1.pdf";
    EasyLoading.show();
    Completer<File> completer = Completer();
    try {
      final filename = "$memoid.pdf";
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var documentdir;
      if (Platform.isAndroid) {
        documentdir = (await getExternalStorageDirectory())!.path;
      } else if (Platform.isIOS) {
        documentdir = (await getApplicationDocumentsDirectory()).path;
      }
      print("Download files");
      print("${documentdir}/$filename");
      File file = File("${documentdir}/${filename}");
      print(file.path);
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      EasyLoading.dismiss();
      emit(PdfPath(path: file.path));
      Navigator.push(context, MaterialPageRoute(builder: (context) => PDFScreen()));
    } catch (e) {
      print(e.toString());
      EasyLoading.showError('Error parsing asset file! \n ${e.toString()}');
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<File> sharePdf(memoid, context) async {
    final url = "https://satu.sipatex.co.id:2087/api/v1/mobile-app/memo-pdf/$memoid/1.pdf";
    EasyLoading.show();
    Completer<File> completer = Completer();
    try {
      final filename = "$memoid.pdf";
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var documentdir;
      if (Platform.isAndroid) {
        documentdir = (await getExternalStorageDirectory())!.path;
      } else if (Platform.isIOS) {
        documentdir = (await getApplicationDocumentsDirectory()).path;
      }
      print("Download files");
      print("${documentdir}/$filename");
      File file = File("${documentdir}/${filename}");
      print(file.path);
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      EasyLoading.dismiss();
      await FlutterShare.shareFile(title: 'Share', text: 'Share document', filePath: file.path);
    } catch (e) {
      print(e.toString());
      EasyLoading.showError('Error parsing asset file! \n ${e.toString()}');
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<void> share(file, context) async {
    print("FILE: $file");
    await FlutterShare.shareFile(title: 'Share', text: 'Share document', filePath: file);
  }
}
