String baseUrl = "https://api2.sipatex.co.id:2096";
String baseUrlAuth = "https://satu.sipatex.co.id:2087";

const TOKEN =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoicm9vdCIsImVtYWlsIjoicm9vdEBsb2NhbGhvc3QifSwiaWF0IjoxNTkyMjM1MzE2fQ.KHYQ0M1vcLGSjJZF-zvTM5V44hM0B8TqlTD0Uwdh9rY";


class MyApi {
  // AUTH
  static login() {
    return "$baseUrlAuth/api/v1/login";
  }

  static logout() {
    return "$baseUrlAuth/api/v1/logout";
  }

  static checkSession() {
    return "$baseUrlAuth/api/v1/check-session";
  }

  // SESSION MANAGER
  static getUserActive() {
    return "$baseUrlAuth/api/v1/user-active";
  }

  static kickUser() {
    return "$baseUrlAuth/api/v1/kick-session";
  }

  // MEMO
  static getMemo(email, perpage, page) {
    return "$baseUrl/memo-paging?email=$email&per_page=$perpage&page=$page";
  }

  static addMemo() {
    return "$baseUrl/memo-store";
  }

  static updateMemo() {
    return "$baseUrl/memo-update";
  }

  static showPdf(memoid) {
    // return "$baseUrlAuth/api/v1/mobile-app/memo-pdf/$memoid/1";
    return "https://satu.sipatex.co.id:2087/api/v1/mobile-app/memo-pdf/$memoid/1";
  }

  // GARDU
  static kwhGardu() {
    return "https://satu.sipatex.co.id:2087/api/v1/chart/kwh-gardu";
  }

  static biayaGardu(tahun, bulan) {
    return "https://satu.sipatex.co.id:2087/api/v1/mobile-app/laporan-produksi/perhitungan-biaya-gardu?tahun=$tahun&bulan=$bulan";
  }

  static laporantProduksi(
    tgl,
    produktifitas_dyeing_finishing,
    gangguan_dyeing_finishing,
    perbaikan_dyeing,
    produktifitas_printing,
    gangguan_printing,
    grading,
    pengiriman,
  ) {
    return "$baseUrlAuth/api/v1/mobile-app/laporan-produksi/rangkuman-harian?tanggal=$tgl&produktifitas_dyeing_finishing=$produktifitas_dyeing_finishing&gangguan_dyeing_finishing=$gangguan_dyeing_finishing&perbaikan_dyeing=$perbaikan_dyeing&produktifitas_printing=$produktifitas_printing&gangguan_printing=$gangguan_printing&grading=$grading&pengiriman=$pengiriman";
  }
}
