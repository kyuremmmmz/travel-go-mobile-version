import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Mailer {
  Future<String> generatePdfReceipt({
    required String amount,
    required int phone,
    required String ref,
    required DateTime date,
    required String account,
    required String gmail,
  }) async {
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
          const pageWidth = 100.0;
          const pageHeight = 100.0;

          return pw.Stack(
            children: [
              pw.Image(pdfImage,
                  fit: pw.BoxFit.fill, width: pageWidth, height: pageHeight),
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
    required String ccEmail,
    required String bcc,
  }) async {
    try {
      // Check if the file exists
      final file = File(filePath);
      if (!await file.exists()) {
        print('File does not exist: $filePath');
        return;
      }

      // Send the email
      final Email email = Email(
        body: body,
        subject: subject,
        recipients: [recipientEmail],
        cc: [ccEmail],
        bcc: [bcc],
        attachmentPaths: [filePath],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<void> sendTestEmail({
    required String recipientEmail,
    required String subject,
    required String body,
  }) async {
    try {
      // Simple email to test
      final Email email = Email(
        body: body,
        subject: subject,
        recipients: [recipientEmail],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      print('Test email sent successfully');
    } catch (e) {
      print('Error sending test email: $e');
    }
  }
}
