import 'dart:io'; // Import Dart's IO library for file handling
import 'package:flutter/material.dart'; // for UI components 
import 'package:flutter/services.dart'; // services for accessing native functionality 
import 'package:mailer/mailer.dart'; // package fir sending emails 
import 'package:mailer/smtp_server.dart'; // Import SMTP server package for email functionality 
import 'package:path_provider/path_provider.dart'; // to access the file system 
import 'package:pdf/pdf.dart'; // pdf document creation 
import 'package:permission_handler/permission_handler.dart'; /// for managing permissions 
import 'package:pdf/widgets.dart' as pw; // alias pw for PDF content creation

class Mailer { // this method from the user 
  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission not granted'); // this throw an exception if permission is not granted 
    }
  }
  // Method to generate a PDF receipt 
  Future<String> generatePdfReceipt({
    required String amount,
    required int phone,
    required String ref,
    required DateTime date,
    required String account,
    required String gmail,
  }) async {
    await requestPermission(); // this request a permission to write to storage 
    // create a new pdf document 
    final pdf = pw.Document();
    // load a background image for the receipt 
    final ByteData receiptBackgroundData =
        await rootBundle.load('assets/images/backgrounds/Receipt.png');
    final Uint8List receiptBackgroundBytes =
        receiptBackgroundData.buffer.asUint8List(); // convert byte data to UintBlist
    final pdfImage = pw.MemoryImage(receiptBackgroundBytes);
    // logo image for the receipt 
    final ByteData logoData =
        await rootBundle.load('assets/images/icon/ButtonX.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final pdfLogo = pw.MemoryImage(logoBytes); // creatae an image from byte data

    // Add a page to the PDF Document 
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack( // Create a stack to overlay images and text
            children: [
              pw.Image(pdfImage, fit: pw.BoxFit.fill), // Set the background image
              pw.Padding(
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start, // Align content to the start
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
                          pw.Divider(color: PdfColor.fromHex("#000000")),  // Add a divider line
                          pw.Text('ACCOUNT: ${account.toUpperCase()}'), // Display account details
                          pw.Text('CONTACT NUMBER: $phone'), // DISPLAY
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

    // Save the PDF file in the temporary directory
    final output = await getTemporaryDirectory(); // Get the temporary directory path
    final filePath = '${output.path}/BookingReceipt.pdf'; // Create the full file path
    final file = File(filePath); // Create a File object
    await file.writeAsBytes(await pdf.save()); // Save the PDF document to the file

    return filePath; // Return the path of the saved PDF
  }

  // Method to send an email with the generated PDF attached
  Future<void> sendEmailWithAttachment(BuildContext context,{
    required String subject,
    required String body,
    required String recipientEmail,
    required String filePath,
  }) async {
    final file = File(filePath);  // Create a File object for the PDF file

    // Check if the file exists before attempting to send it
    if (await file.exists()) {
      const smtpServerAddress = 'smtp.gmail.com';  // Gmail SMTP server
      const smtpUsername = 'kurosawataki84@gmail.com';
      const smtpPassword = 'fwie bneh yhuf pkkf';
       // Create an SMTP server object using the defined settings
      final smtpServer = SmtpServer(smtpServerAddress,
          username: smtpUsername, password: smtpPassword);
      // Create an email message with the necessary details
      final message = Message()
        ..from = const Address(smtpUsername, 'Travel Go')
        ..recipients.add(recipientEmail)
        ..subject = subject
        ..text = body
        ..attachments.add(FileAttachment(file));  // Attach the PDF file

      try {
        // Attempt to send the email
        final sendReport = await send(message, smtpServer); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:  Text(
            'Email sent successfully!', // Show a success message upon successful email sending
            
          ))
        );
        debugPrint('Email sent: $sendReport'); // Log the send report
      } catch (e) {
        debugPrint('Error sending email: $e');
      }
    } else {
      debugPrint('File does not exist: $filePath');
    }
  }
}
