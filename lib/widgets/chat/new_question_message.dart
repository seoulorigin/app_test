import 'package:flutter/material.dart';

class NewQuestionMessage extends StatelessWidget {
  final String question;
  final VoidCallback onAskQuestion;

  const NewQuestionMessage({
    super.key,
    required this.question,
    required this.onAskQuestion,
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
                '아직 등록되지 않은 질문입니다.\n질문을 등록하시겠습니까?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: onAskQuestion,
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: const Text('질문하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 