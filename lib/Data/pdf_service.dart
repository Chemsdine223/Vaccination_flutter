import 'dart:io';
// import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  CustomRow(this.itemName, this.itemPrice, this.amount, this.total, this.vat);
}

class PdfInvoiceService {
  CustomRow customRow =
      CustomRow('itemName', 'itemPrice', 'amount', 'total', 'vat');
  Future<Uint8List> createHelloWorld(
    String name,
    String lastName,
    String centre,
    String status,
  ) async {
    final image =
        (await rootBundle.load('Img/qr-code.png')).buffer.asUint8List();
    // final image = pw.MemoryImage(
    //   File('Img/qr-code.png').readAsBytesSync(),
    // );

    final fontData =
        await rootBundle.load('fonts/JetBrainsMono-VariableFont_wght.ttf');
    final ttf = Font.ttf(fontData);
    // final customFont = pw.Font.ttf(fontData.buffer.asUint8List());
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // pw.Image(image),
              pw.Center(
                child: pw.Text('Certificat de vaccination',
                    style: TextStyle(
                      fontSize: 16,
                      color: PdfColors.red,
                      font: ttf,
                    )),
              ),
              // pw.SizedBox(height: 20),
              pw.Divider(
                thickness: .1,
              ),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Information certificat :',
                      style: const TextStyle(
                        // font: ttf,
                        decoration: TextDecoration.underline,
                      )),
                ],
              ),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Date du certificat',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Text(
                    '22/05/2023',
                    // style: const TextStyle(
                    //   decoration: TextDecoration.underline,
                    // ),
                  ),
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Personne vacciné:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Nom:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    'Chemsdine',
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'NNI:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    '3121317896',
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Date de naissance:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    '18/09/1999',
                  ),
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Text(
                'Injections/centre :',
                style: const TextStyle(
                  // font: ttf,
                  decoration: TextDecoration.underline,
                ),
              ),
              pw.SizedBox(height: 10),

              pw.Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Dose:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    '1/1',
                  ),
                ],
              ),
              pw.Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Vaccin:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    'Vysor',
                  ),
                ],
              ),
              pw.Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Centre:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    'Tevragh zeina',
                  ),
                ],
              ),
              pw.Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Date:',
                    style: const TextStyle(
                      // font: ttf,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  pw.Text(
                    '12/12/2012',
                  ),
                ],
              ),
              SizedBox(height: 20),
              pw.Image(
                height: 50,
                width: 50,
                MemoryImage(image),
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    try {
      final output = await getTemporaryDirectory();
      var filePath = '${output.path}/$fileName.pdf';
      final file = File(filePath);
      await file.writeAsBytes(byteList);
      await OpenFile.open(filePath);
    } catch (e) {
      // Handle and log the exception
      print('Error saving PDF file: $e');
      // You can also display an error message to the user if needed
    }
  }
}
