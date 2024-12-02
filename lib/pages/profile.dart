import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sustanify/main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyApp.isDarkMode,
      builder: (context, isDark, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark ? Colors.black : const Color(0xFF146BB6),
            title: const Text('Profile Page'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ProfileScreen(isDark: isDark),
        );
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final bool isDark;
  const ProfileScreen({super.key, required this.isDark});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.displayName);
    _emailController = TextEditingController(text: user.email);
  }

  Future<void> _updateName() async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await user.updateDisplayName(newName);
      await user.reload();
      setState(() {}); // Reflect changes in the UI
    }
  }

  Future<void> _updateEmail() async {
    final newEmail = _emailController.text.trim();
    if (newEmail.isNotEmpty && newEmail != user.email) {
      await user.updateEmail(newEmail);
      await user.reload();
      setState(() {}); // Reflect changes in the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user.photoURL ?? 'https://via.placeholder.com/150',
              ),
            ),
            const SizedBox(height: 20),

            // Name Change Section
            ListTile(
              title: const Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: _updateName,
              ),
            ),
            Divider(color: widget.isDark ? Colors.grey : Colors.black),

            // Email Change Section
            ListTile(
              title: const Text(
                'Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: _updateEmail,
              ),
            ),
            Divider(color: widget.isDark ? Colors.grey : Colors.black),

            // Password Change Section
            ListTile(
              title: const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('•••••••••'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to a password change screen or show a dialog
                },
              ),
            ),
            Divider(color: widget.isDark ? Colors.grey : Colors.black),
          ],
        ),
      ),
    );
  }
}
