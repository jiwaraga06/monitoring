class GANGGUANDFVIEW {
  static htmlContent(body) {
    var html = """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Produktifitas Dyeing Finishing</title>
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
        <div class="col">
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
            </div>
            <div class="row">
                <h5>-- GANGGUAN DYEING FINISHING</h5>
                
            </div>
            <table class="table table-bordered" style="margin-top: 5px; text-align: center; border-color: #454545; ">
                <thead>
                    <tr>
                        <th colspan="6">
                            <h6><b>GANGGUAN DYEING FINISHING</b></h6>
                        </th>
                    </tr>
                    <tr>
                        <th style="width: 15%;">
                            <h6><b>JAM STOP DOMINAN DF</b></h6>
                        </th>
                        <th colspan="3">
                            <h6><b>JAM</b></h6>
                        </th>
                        
                        <th style="width: 15%;">
                            <h6><b>AKUMULASI JAM STOP</b></h6>
                        </th>
                    </tr>
                </thead>
                <tbody> """;
    body['gangguan'].forEach((key, b) {
      html += """
                      <tr>
                        <td>
                            <p>${key ?? ""}</p>
                        </td>
                        <td style="width: 10%;">
                            <p>${b['jam'] ?? ""}</p>
                        </td>
                        <td colspan="2" style="width: 50%; text-align: start;">
                             <p>${b['jam_detail'] ==null?"": b['jam_detail'].toString().replaceAll("{", " ").replaceAll("}"," ")}</p>
                        </td>
                        <td>
                            <p>${b['akumulasi_jam_stop'] ?? ""}</p>
                        </td>
                    </tr>
""";
    });

    html += """              </tbody>
            </table>

        </div>
</body>

</html>""";

    return html;
  }
}
