import 'package:intl/intl.dart';

class PDFBIAYAGARDU {
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

    .row {
        display: flex;
        flex-direction: row;
    }

    .col {
        display: flex;
        flex-direction: column;
    }

    /* .tables th,td,tr{
        border-collapse: collapse;
        
    } */
</style>

<body>
    <div class="container" style="padding-top: 20px;">
        <h6 style="text-align: center; font-size: 20px;">Potensi Biaya Gardu Periode ${body['periode']}</h6>
        <div class="box" style="margin-bottom: 15px;"></div>
        <table class="table table-bordered" style="margin-top: 8px; text-align: center; border-color: #454545; ">
            <thead style="background-color: #D8D8D8;">
                <tr>
                    <th>
                        <h6><b>Kategori</b></h6>
                    </th>
                    <th>
                        <h6><b>Rata - Rata Perhari</b></h6>
                    </th>
                    <th>
                        <h6><b>Estimasi Per Bulan</b></h6>
                    </th>
                </tr>
            </thead>
            <tbody>""";
    body['biaya'].forEach((key, b) {
      if (key == "last_date") {
        html += """
                <div></div>
        """;
      } else {
        html += """
                <tr>
                    <td>
                        <p>${key}</p>
                    </td>
                    <td>
                        <p>Rp. ${format.format(b['rata_rata_perhari'])}</p>
                    </td>
                    <td>
                        <p>Rp. ${format.format(b['estimasi_biaya_perbulan'])}</p>
                    </td>
                </tr>
            """;
      }
    });
    html += """ </tbody>
        </table>
        <div class="container">
            <p><i>Last Update : ${body['last_date']}</i></p>
        </div>

    </div>
</body>

</html>
""";
    return html;
  }
}
