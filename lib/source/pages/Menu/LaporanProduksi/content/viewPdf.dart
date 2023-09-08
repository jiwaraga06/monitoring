import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:monitoring/source/services/LaporanProduksi/cubit/laporan_produksi_cubit.dart';
import 'package:monitoring/source/services/Memo/cubit/pdf_cubit.dart';

class PDFLaporanProduksi extends StatefulWidget {
  const PDFLaporanProduksi({Key? key}) : super(key: key);

  _PDFLaporanProduksiState createState() => _PDFLaporanProduksiState();
}

class _PDFLaporanProduksiState extends State<PDFLaporanProduksi> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Laporan Produksi"),
        actions: [
          BlocBuilder<LaporanProduksiCubit, LaporanProduksiState>(
            builder: (context, state) {
              if (state is LaporanProduksiPdf == false) {
                return Container();
              }
              var path = (state as LaporanProduksiPdf).path;
              print('PATH: $path');
              if (path == null) {
                return const Center(
                  child: Text('Path unknown'),
                );
              }
              return IconButton(
                onPressed: () {
                  BlocProvider.of<PdfCubit>(context).share(path, context);
                },
                icon: Icon(Icons.share),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<LaporanProduksiCubit, LaporanProduksiState>(
        builder: (context, state) {
          if (state is LaporanProduksiPdf == false) {
            return Container();
          }
          var path = (state as LaporanProduksiPdf).path;
          print('PATH: $path');
          if (path == null) {
            return const Center(
              child: Text('Path unknown'),
            );
          }
          return Stack(
            children: <Widget>[
              PDFView(
                filePath: path,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                defaultPage: currentPage!,
                fitPolicy: FitPolicy.BOTH,
                preventLinkNavigation: false,
                onRender: (_pages) {
                  setState(() {
                    pages = _pages;
                    isReady = true;
                  });
                },
                onError: (error) {
                  setState(() {
                    errorMessage = error.toString();
                  });
                  print(error.toString());
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage = '$page: ${error.toString()}';
                  });
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onLinkHandler: (String? uri) {
                  print('goto uri: $uri');
                },
                onPageChanged: (int? page, int? total) {
                  print('page change: $page/$total');
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                  : Center(
                      child: Text(errorMessage),
                    )
            ],
          );
        },
      ),
    );
  }
}
