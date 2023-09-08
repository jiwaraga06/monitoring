import 'package:intl/intl.dart';

class PENGIRIMANVIEW {
  static htmlContent(body) {
    var format = NumberFormat('#,##0.00', "ID");
    var html = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Pengiriman</title>
</head>
<style>
    .box {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #1d1d1d;
        height: 5px;
    }
</style>

<body>
    <div class="container" style="padding-top: 20px;">
        <h6 style="text-align: center;">RANGKUMAN LAPORAN HARIAN PRODUKSI</h6>
        <div class="box" style="margin-bottom: 20px;"></div>
       <div class="row">
       <div class="row">
            <div class="col-4">
                <p>Hari/Tanggal Produksi</p>
            </div>
            <div class="col-1">
                <p>:</p>
            </div>
            <div class="col">
                <p>${body['tglProduksi']}</p>
            </div>
        </div>
        <div class="row">
            <div class="col-4">
                <p>Hari/Tanggal Cetak</p>
            </div>
            <div class="col-1">
                <p>:</p>
            </div>
            <div class="col">
                <p>${body['tglCetak']}</p>
            </div>
        </div>
        <div class="row">
            <div class="col-4">
                <p>Di Cetak oleh</p>
            </div>
            <div class="col-1">
                <p>:</p>
            </div>
            <div class="col">
                <p>${body['nama']}</p>
            </div>
        </div>
        <div class="row">
            <h5>-- PENGIRIMAN</h5>
        </div>
        <table class="table table-bordered" style="margin-top: 5px; text-align: center; border-color: #454545; ">
            <thead>
                <tr>
                    <th rowspan="2" style="text-align: start; align-items: center;">
                        <h6 style="margin-bottom: 25px;"><b>PRODUKTIFITAS</b></h6>
                    </th>
                    <th colspan="2">
                        <h6><b>HARI</b></h6>
                    </th>
                    <th colspan="2">
                        <h6><b>BULAN</b></h6>
                    </th>
                    </th>
                </tr>
                <tr>
                    <th>
                        <h6><b>PCS</b></h6>
                    </th>
                    <th>
                        <h6><b>YARD</b></h6>
                    </th>
                    <th>
                        <h6><b>PCS</b></h6>
                    </th>
                    <th>
                        <h6><b>YARD</b></h6>
                    </th>
                </tr>
            </thead>
            <tbody>""";
    body['pengiriman'].forEach((key, b) {
      html += """
     <tr>
                    <td style="text-align: start;">
                        <p>${key}</p>
                    </td>
                    <td>
                        <p>${format.format(double.parse(b['pcs'].toString()))}</p>
                    </td>
                    <td>
                        <p>${format.format(double.parse(b['yards'].toString()))}</p>
                    </td>
                    <td>
                        <p>${format.format(double.parse(b['pcs_perbulan'].toString()))}</p>
                    </td>
                    <td>
                    <p>${format.format(double.parse(b['yards_perbulan'].toString()))}</p>
                    </td>
                </tr>
""";
    });
    html += """     </tbody>

        </table>
    </div>
</body>

</html>
""";
    return html;
  }
}
