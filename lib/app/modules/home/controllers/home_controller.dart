import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  var product = List.generate(
    5,
    (index) => {
      'id': ' # ${index + 1}',
      'name': 'Product ke ${index + 1}',
      'desc': DateTime.now().toString(),
    },
  );

  void getPDF() async {
    // 1. buat class pdf
    final pdf = pw.Document();

    // 2. buat page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World", style: pw.TextStyle(fontSize: 50)),
          ); // Center
        },
      ),
    ); // Page

    // 3. simpan
    Uint8List saveInBytes = await pdf.save();

    // 4. buat file kosong di directory
    final directory =
        await getApplicationDocumentsDirectory(); // -> digunakan untuk simpan file
    final file = File('${directory.path}/mydocument.pdf');

    // 5. timpa file semula kosong ke pdf kita
    await file.writeAsBytes(saveInBytes);

    // 6. open pdf
    await OpenFile.open(file.path);
  }
}
