import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppScreen extends StatefulWidget {
  @override
  _WhatsAppScreenState createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedCountryCode = '+1'; // Default country code (change as needed)

  void openWhatsApp() async {
    final phoneNumber = phoneNumberController.text;
    final fullNumber = "$selectedCountryCode$phoneNumber";
    final url = "https://wa.me/$fullNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ChatBridge')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://res.cloudinary.com/practicaldev/image/fetch/s--E5VhGR2w--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/eu5qnbj3326gpaalps6y.gif',
                width: 500, // Adjust the width as needed
                height: 200, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedCountryCode,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountryCode = newValue!;
                      });
                    },
                    items: <String>[
                      '+1',
                      '+91',
                      '+44',
                      '+62'
                    ] // Add more country codes as needed
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Enter Mobile Number',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: openWhatsApp,
                child: const Text('Open in WhatsApp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
