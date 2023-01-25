import 'package:url_launcher/url_launcher.dart';

class url {

Future<void> makePhoneCall(String phoneNumber) async {
    
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

Future <void> sendMessage (String phoneNumber) async {

  final Uri launchUri = Uri (

    scheme: 'sms',
    path: phoneNumber
  );
  await launchUrl(launchUri);
}

Future <void> sendEmail (String Email) async {

  final Uri launchUri = Uri (

    scheme: 'mailto',
    path: Email
  );
  await launchUrl(launchUri);
}

}