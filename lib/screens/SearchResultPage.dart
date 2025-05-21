import 'package:flutter/material.dart';
import '../widgets/chat/answered_question_message.dart';
import '../widgets/chat/unanswered_question_message.dart';
import '../widgets/chat/new_question_message.dart';
import '../widgets/search/search_bar_widget.dart';
import 'SearchResultPage.dart';

class SearchResultPage extends StatefulWidget {
  final String? initialQuestion;
  const SearchResultPage({super.key, this.initialQuestion});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialQuestion != null && widget.initialQuestion!.trim().isNotEmpty) {
      _messages.add({
        'role': 'user',
        'text': widget.initialQuestion!,
      });

      // 검색어에 따라 다른 메시지 타입 설정
      if (widget.initialQuestion == "a") {
        _messages.add({
          'role': 'bot',
          'type': 'answered',
          'text': widget.initialQuestion!,
          'answer': '이것은 답변된 질문입니다.',
        });
      } else if (widget.initialQuestion == "b") {
        _messages.add({
          'role': 'bot',
          'type': 'unanswered',
          'text': widget.initialQuestion!,
        });
      } else {
        _messages.add({
          'role': 'bot',
          'type': 'new',
          'text': widget.initialQuestion!,
        });
      }
    }
  }

  void _search() {
    final question = _controller.text.trim();
    if (question.isEmpty) return;
    
    // 키보드 내리기
    FocusScope.of(context).unfocus();
    
    // 새로운 SearchResultPage로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(initialQuestion: question),
      ),
    );
  }

  void _handleLike() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('좋아요가 반영되었습니다.')),
    );
  }

  void _handleDislike() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('싫어요가 반영되었습니다.')),
    );
  }

  void _handleNewQuestion() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('새 질문 등록 페이지로 이동합니다.')),
    );
  }

  void _handleNotify() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('답변 알림이 설정되었습니다.')),
    );
  }

  void _handleAskQuestion() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('질문하기 페이지로 이동합니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                    
                    if (isUser) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            msg['text'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }

                    // 봇 메시지 처리
                    final type = msg['type'] as String?;
                    if (type == 'answered') {
                      return AnsweredQuestionMessage(
                        question: msg['text'] ?? '',
                        answer: msg['answer'] ?? '',
                        onLike: _handleLike,
                        onDislike: _handleDislike,
                      );
                    } else if (type == 'unanswered') {
                      return UnansweredQuestionMessage(
                        question: msg['text'] ?? '',
                        onNewQuestion: _handleNewQuestion,
                        onNotify: _handleNotify,
                      );
                    } else {
                      return NewQuestionMessage(
                        question: msg['text'] ?? '',
                        onAskQuestion: _handleAskQuestion,
                      );
                    }
                  },
                ),
              ),
            SearchBarWidget(
              controller: _controller,
              onSearch: _search,
            ),
          ],
        ),
      ),
    );
  }
}
