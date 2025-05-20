import 'package:flutter/material.dart';

class UnansweredQuestionMessage extends StatelessWidget {
  final String question;
  final VoidCallback onNewQuestion;
  final VoidCallback onNotify;

  const UnansweredQuestionMessage({
    super.key,
    required this.question,
    required this.onNewQuestion,
    required this.onNotify,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '아직 답변되지 않은 질문입니다.',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                children: [
                  TextButton.icon(
                    onPressed: onNewQuestion,
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                    label: const Text('새로 질문 올리기'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onNotify,
                    icon: const Icon(Icons.notifications_outlined, size: 20),
                    label: const Text('답변 알림받기'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
} 