import 'package:monitoring/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});
  // AUTH
  Future login(body) async {
    var json = await myNetwork!.login(body);
    return json;
  }

  Future logout(body) async {
    var json = await myNetwork!.logout(body);
    return json;
  }

  Future checkSession(body) async {
    var json = await myNetwork!.checkSession(body);
    return json;
  }

  // SESSION MANAGER

  Future getUserActive() async {
    var json = await myNetwork!.getUserActive();
    return json;
  }

  Future kickUser(body) async {
    var json = await myNetwork!.kickUser(body);
    return json;
  }

  // MEMO
  Future showPdf(memoid) async {
    var json = await myNetwork!.showPdf(memoid);
    return json;
  }

  Future getMemo(email, perpage, page) async {
    var json = await myNetwork!.getMemo(email, perpage, page);
    return json;
  }

  Future addMemo(body) async {
    var json = await myNetwork!.addMemo(body);
    return json;
  }

  Future updateMemo(body) async {
    var json = await myNetwork!.updateMemo(body);
    return json;
  }

  //
  Future kwhGardu(body) async {
    var json = await myNetwork!.kwhGardu(body);
    return json;
  }

  Future biayaGardu(tahun, bulan) async {
    var json = await myNetwork!.biayaGardu(tahun, bulan);
    return json;
  }

  Future laporantProduksi(tgl,
    produktifitas_dyeing_finishing,
    gangguan_dyeing_finishing,
    perbaikan_dyeing,
    produktifitas_printing,
    gangguan_printing,
    grading,
    pengiriman,
  ) async {
    var json = await myNetwork!.laporanProduksi(tgl,
        produktifitas_dyeing_finishing, gangguan_dyeing_finishing, perbaikan_dyeing, produktifitas_printing, gangguan_printing, grading, pengiriman);
    return json;
  }
}
