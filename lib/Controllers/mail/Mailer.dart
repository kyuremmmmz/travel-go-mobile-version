import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class Mailer {
  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission not granted');
    }
  }

  Future<String> generatePdfReceipt({
    required String amount,
    required int phone,
    required String ref,
    required DateTime date,
    required String account,
    required String gmail,
  }) async {
    await requestPermission();

    final pdf = pw.Document();

    final ByteData receiptBackgroundData =
        await rootBundle.load('assets/images/backgrounds/Receipt.png');
    final Uint8List receiptBackgroundBytes =
        receiptBackgroundData.buffer.asUint8List();
    final pdfImage = pw.MemoryImage(receiptBackgroundBytes);

    final ByteData logoData =
        await rootBundle.load('assets/images/icon/ButtonX.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final pdfLogo = pw.MemoryImage(logoBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Image(pdfImage, fit: pw.BoxFit.fill),
              pw.Padding(
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Image(pdfLogo, width: 40, height: 40),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Booking Confirmed!',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex("#006B92"),
                      ),
                    ),
                    pw.Text('Date: ${date.toLocal()}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Thank You for Your Booking!',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: PdfColor.fromHex("#0A2C48"),
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("#FFFFFF"),
                          border: pw.Border.all(
                              color: PdfColor.fromHex("#000000"))),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('BILLER',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Travel Go',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#0567B4"))),
                            ],
                          ),
                          pw.Divider(color: PdfColor.fromHex("#000000")),
                          pw.Text('ACCOUNT: ${account.toUpperCase()}'),
                          pw.Text('CONTACT NUMBER: $phone'),
                          pw.Text('EMAIL: $gmail'),
                          pw.Text('AMOUNT: PHP $amount'),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      width: 900,
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("#FFFFFF"),
                          border: pw.Border.all(
                              color: PdfColor.fromHex("#000000"))),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          pw.Text('TOTAL AMOUNT: $amount',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('Paid using PayPal',
                              style: pw.TextStyle(
                                  color: PdfColor.fromHex("#0567B4"))),
                          pw.Text('Date Paid: ${date.toLocal()}'),
                          pw.Text('Reference No: $ref'),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 40),
                    pw.Text('Travel Go © 2024',
                        style: const pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF file
    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/BookingReceipt.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  Future<void> sendEmailWithAttachment({
    required String subject,
    required String body,
    required String recipientEmail,
    required String filePath,
  }) async {
    final file = File(filePath);

    if (await file.exists()) {
      const smtpServerAddress = 'smtp.gmail.com';
      const smtpUsername = 'kurosawataki84@gmail.com';
      const smtpPassword = 'fwie bneh yhuf pkkf';

      final smtpServer = SmtpServer(smtpServerAddress,
          username: smtpUsername, password: smtpPassword);

      final message = Message()
        ..from = const Address(smtpUsername, 'Travel Go')
        ..recipients.add(recipientEmail)
        ..subject = subject
        ..text = body
        ..attachments.add(FileAttachment(file));

      try {
        final sendReport = await send(message, smtpServer);
        print('Email sent: $sendReport');
      } catch (e) {
        print('Error sending email: $e');
      }
    } else {
      print('File does not exist: $filePath');
    }
  }
}
