import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    this.hintText = '무엇이든 부탁하세요',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.white.withOpacity(0.95),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: onSearch,
            ),
          ),
        ],
      ),
    );
  }
} 