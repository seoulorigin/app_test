import 'package:flutter/material.dart';

class AnsweredQuestionMessage extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const AnsweredQuestionMessage({
    super.key,
    required this.question,
    required this.answer,
    required this.onLike,
    required this.onDislike,
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
              Text(
                answer,
                style: const TextStyle(
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
                    onPressed: onLike,
                    icon: const Icon(Icons.thumb_up_outlined, size: 20),
                    label: const Text('좋아요'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onDislike,
                    icon: const Icon(Icons.thumb_down_outlined, size: 20),
                    label: const Text('싫어요'),
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