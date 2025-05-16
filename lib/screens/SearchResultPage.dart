import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final String? initialQuestion;
  const SearchResultPage({super.key, this.initialQuestion});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialQuestion != null && widget.initialQuestion!.trim().isNotEmpty) {
      _messages.add({'role': 'user', 'text': widget.initialQuestion!});
      _messages.add({'role': 'bot', 'text': '이것은 "${widget.initialQuestion}"에 대한 임시 답변입니다.'});
    }
  }

  void _sendMessage() {
    final question = _controller.text.trim();
    if (question.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _messages.add({'role': 'bot', 'text': '이것은 "$question"에 대한 임시 답변입니다.'});
      _controller.clear();
    });
    // 스크롤을 맨 아래로 이동
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('검색 결과')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (_messages.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    '무엇을 도와드릴까요?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg['role'] == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.black : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          msg['text'] ?? '',
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            Container(
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
                        controller: _controller,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration(
                          hintText: '무엇이든 부탁하세요',
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
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
