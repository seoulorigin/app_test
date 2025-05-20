import 'package:flutter/material.dart';
import 'password_input_page.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  bool _isCodeSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    // TODO: 실제 이메일 인증 코드 전송 로직 구현
    setState(() {
      _isCodeSent = true;
    });
  }

  void _verifyCode() {
    // TODO: 실제 인증 코드 확인 로직 구현
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordInputPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일 인증'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '이메일 주소를 입력해주세요',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: '이메일 주소',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _sendVerificationCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '인증 코드 받기',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '인증 코드를 입력해주세요',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _verificationCodeController,
              decoration: const InputDecoration(
                hintText: '인증 코드',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: _isCodeSent,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isCodeSent ? _verifyCode : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '인증하기',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 