import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  var product = List.generate(
    20,
    (index) => {
      'id': ' # ${index + 1}',
      'name': 'Product ke ${index + 1}',
      'desc': DateTime.now().toString(),
    },
  );

  void getPDF() async {
    // buat font
    var dataFont = await rootBundle.load('assets/PlaywriteHU-Regular.ttf');
    var myFont = pw.Font.ttf(dataFont);
    //  buat gambar
    var dataImage = await rootBundle.load('assets/image.jpg');
    var myImage =
        dataImage.buffer.asUint8List(); // converdari bytes ke Uint8List

    // 1. buat class pdf
    final pdf = pw.Document();

    // 2. buat page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.ClipRRect(
              horizontalRadius: 20,
              verticalRadius: 20,
              child: pw.Container(
                height: 170,
                width: 200,
                child: pw.Image(
                  // baca file Uint8List
                  pw.MemoryImage(myImage),
                  fit: pw.BoxFit.cover,
                ),
              ),
            ),
            pw.SizedBox(height: 20),

            pw.Container(
              color: PdfColors.purple300,
              alignment: pw.Alignment.center,
              width: double.infinity,
              child: pw.Text(
                'My Products',
                style: pw.TextStyle(fontSize: 50, font: myFont),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              children:
                  product
                      .map(
                        (e) => pw.Text(
                          'ID : ${e['id']} - NAME : ${e['name']} - \n DESC : ${e['desc']} \n',
                          style: pw.TextStyle(fontSize: 30, font: myFont),
                        ),
                      )
                      .toList(),
            ),
          ];
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
