import 'package:flutter/material.dart';
import 'package:sustanify/main.dart'; // Import MyApp to access isDarkMode

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            subtitle: const Text('Change app theme'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThemeSettingsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Terms & Conditions'),
            subtitle: const Text('View terms and conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('FAQs'),
            subtitle: const Text('Frequently Asked Questions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Dark Mode', style: TextStyle(fontSize: 18)),
            ValueListenableBuilder(
              valueListenable: MyApp.isDarkMode,
              builder: (context, isDark, child) {
                return Switch(
                  value: isDark,
                  onChanged: (value) {
                    MyApp.isDarkMode.value = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction\n\nWelcome to the app. By using this application, you agree to comply with and be bound by the following terms and conditions.\n\n2. User Obligations\n\nYou agree to use the app in compliance with applicable laws and not to misuse the services provided.\n\n3. Privacy\n\nWe respect your privacy and are committed to protecting your personal information. Please refer to our Privacy Policy for more details.\n\n4. Termination\n\nWe may suspend or terminate your access to the app at any time without notice for any breach of these terms.\n\n5. Changes\n\nWe reserve the right to modify these terms at any time. Please check this page regularly for updates.\n\n6. Governing Law\n\nThese terms are governed by the laws of the country where the company is located.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Frequently Asked Questions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Q1: How do I change the app theme?\n\nA: To change the theme, go to the Settings page and toggle the Dark Mode switch.\n\nQ2: How do I reset my password?\n\nA: You can reset your password by going to the login screen and selecting "Forgot Password." You will receive a link to reset your password.\n\nQ3: Is my data secure?\n\nA: Yes, we use encryption to protect your personal information. For more details, please refer to our Privacy Policy.\n\nQ4: How do I contact support?\n\nA: You can contact support by emailing us at support@app.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
