import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Mailer {
  // Generate HTML receipt
  String generateHtmlReceipt({
    required String amount,
    required int phone,
    required String ref,
    required DateTime date,
  }) {
    return '''
    <!DOCTYPE html>
      <html>
        <head>
          <title>Booking Receipt</title>
        </head>
        <body style="font-family: Arial, sans-serif;">
          <div style="width: 80%; margin: 0 auto;">
            <div style="background-color: #f5f5f5; padding: 20px; text-align: center;">
              <h2>Thank you for your booking!</h2>
            </div>
            <div style="padding: 20px;">
              <p style="line-height: 1.5;"><strong>Date:</strong> $date</p>
              <p style="line-height: 1.5;"><strong>Amount:</strong> PHP $amount</p>
              <p style="line-height: 1.5;"><strong>Contact Number:</strong> $phone</p>
              <p style="line-height: 1.5;"><strong>Reference Number:</strong> $ref</p>
            </div>
            <div style="text-align: center; margin-top: 20px; font-size: 12px;">
              <p>Travel Go &copy; 2024</p>
            </div>
          </div>
        </body>
      </html>
    ''';
  }

  // Save HTML file
  Future<String> saveHtmlFile(String htmlContent) async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
      return '';
    }

    try {
      Directory? directory = await getExternalStorageDirectory();
      String path = directory!.path;
      File file = File('$path/BookingReceipt.html');

      await file.writeAsString(htmlContent);
      print('HTML file saved: ${file.path}');
      return file.path;
    } catch (e) {
      print('Error saving HTML file: $e');
      return '';
    }
  }

  // Send email with HTML content
  Future<void> sendEmail({
    required String subject,
    required String htmlContent,
    required String recipientEmail,
    required String ccEmail,
    required String bcc,
  }) async {
    try {
      await FlutterEmailSender.send(Email(
        body: htmlContent,
        subject: subject,
        recipients: [recipientEmail],
        cc: [ccEmail],
        bcc: [bcc],
        isHTML: true,
      ));
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
