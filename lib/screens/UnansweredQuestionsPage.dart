import 'package:flutter/material.dart';

class UnansweredQuestionsPage extends StatelessWidget {
  const UnansweredQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 데이터로 교체
    final List<String> unansweredQuestions = [
      '앱 사용 방법이 궁금해요.',
      '비밀번호를 잊어버렸어요.',
      '회원 탈퇴는 어떻게 하나요?',
      '포인트 적립은 어떻게 하나요?',
      '배송 조회는 어디서 하나요?',
      '환불은 언제 되나요?',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('답변 대기 질문'),
      ),
      body: ListView.builder(
        itemCount: unansweredQuestions.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              title: Text(
                unansweredQuestions[index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 질문 상세 페이지로 이동
              },
            ),
          );
        },
      ),
    );
  }
} 