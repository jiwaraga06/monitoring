import 'dart:async';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring/source/network/api.dart';

class MyNetwork {
  // AUTH
  Future login(body) async {
    try {
      var url = Uri.parse(MyApi.login());
      var response = await http.post(url, body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future logout(body) async {
    try {
      var url = Uri.parse(MyApi.logout());
      var response = await http.post(url, body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future checkSession(body) async {
    try {
      var url = Uri.parse(MyApi.checkSession());
      var response = await http.post(url, body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  // SESSION MANAGER
  Future getUserActive() async {
    try {
      var url = Uri.parse(MyApi.getUserActive());
      var response = await http.get(url);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future kickUser(body) async {
    try {
      var url = Uri.parse(MyApi.kickUser());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
          body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  // MEMO
  Future showPdf(memoid) async {
    try {
      var url = Uri.parse(MyApi.showPdf(memoid));
      var response = await http.get(url, headers: {
        // 'Authorization': 'Bearer $TOKEN',
      });
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future getMemo(email, perpage, page) async {
    try {
      var url = Uri.parse(MyApi.getMemo(email, perpage, page));
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $TOKEN',
      });
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future addMemo(body) async {
    try {
      var url = Uri.parse(MyApi.addMemo());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $TOKEN',
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
          body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future updateMemo(body) async {
    try {
      var url = Uri.parse(MyApi.updateMemo());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $TOKEN',
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
          body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future kwhGardu(body) async {
    try {
      var url = Uri.parse(MyApi.kwhGardu());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $TOKEN',
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
          body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future biayaGardu(tahun, bulan) async {
    try {
      var url = Uri.parse(MyApi.biayaGardu(tahun, bulan));
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $TOKEN',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
      );
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future laporanProduksi(tgl,
    produktifitas_dyeing_finishing,
    gangguan_dyeing_finishing,
    perbaikan_dyeing,
    produktifitas_printing,
    gangguan_printing,
    grading,
    pengiriman,
  ) async {
    try {
      var url = Uri.parse(MyApi.laporantProduksi(tgl,
          produktifitas_dyeing_finishing, gangguan_dyeing_finishing, perbaikan_dyeing, produktifitas_printing, gangguan_printing, grading, pengiriman));
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $TOKEN',
        },
      );
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }
}
