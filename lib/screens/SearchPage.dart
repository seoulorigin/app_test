import 'package:flutter/material.dart';
import 'MenuDrawer.dart';
import 'user_info/email_verification_page.dart';
import '../widgets/chat/answered_question_message.dart';
import '../widgets/chat/unanswered_question_message.dart';
import '../widgets/chat/new_question_message.dart';
import 'UnansweredQuestionsPage.dart';
import 'SearchResultPage.dart';
import '../widgets/search/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _showChat = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _search() {
    final question = _controller.text.trim();
    if (question.isEmpty) return;
    // 키보드 내리기
    FocusScope.of(context).unfocus();
    
    // SearchResultPage로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(initialQuestion: question),
      ),
    );
    
    _controller.clear();
  }

  void _handleLike() {
    // TODO: 좋아요 처리 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('좋아요가 반영되었습니다.')),
    );
  }

  void _handleDislike() {
    // TODO: 싫어요 처리 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('싫어요가 반영되었습니다.')),
    );
  }

  void _handleNewQuestion() {
    // TODO: 새 질문 등록 페이지로 이동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('새 질문 등록 페이지로 이동합니다.')),
    );
  }

  void _handleNotify() {
    // TODO: 알림 설정 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('답변 알림이 설정되었습니다.')),
    );
  }

  void _handleAskQuestion() {
    // TODO: 질문하기 페이지로 이동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('질문하기 페이지로 이동합니다.')),
    );
  }

  void _reset() {
    // 키보드 내리기
    FocusScope.of(context).unfocus();
    setState(() {
      _showChat = false;
      _messages.clear();
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> faqList = [
      '앱 사용 방법이 궁금해요.',
      '비밀번호를 잊어버렸어요.',
      '회원 탈퇴는 어떻게 하나요?',
      '포인트 적립은 어떻게 하나요?',
      '배송 조회는 어디서 하나요?',
      '환불은 언제 되나요?',
      '가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하',
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const MenuDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _showChat
                  ? Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: _reset,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '검색 결과',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) => IconButton(
                                  icon: const Icon(Icons.menu, size: 28),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ),
                              const Text(
                                '무엇을 도와드릴까요?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                icon: const Icon(Icons.person_outline, size: 28),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EmailVerificationPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        // 카드 목록 (스크롤 가능, 한 화면에 3개 보이도록 Expanded)
                        Expanded(
                          child: ListView.builder(
                            itemCount: faqList.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 0,
                            ),
                            itemBuilder: (context, i) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  color:
                                      Colors
                                          .primaries[i %
                                              Colors.primaries.length]
                                          .shade100,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    constraints: const BoxConstraints(
                                      minHeight: 80,
                                    ),
                                    child: Center(
                                      child: Text(
                                        faqList[i],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // 답변하러 가기 버튼
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UnansweredQuestionsPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: const Text(
                                '답변하러 가기',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SearchBarWidget(
                          controller: _controller,
                          onSearch: _search,
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
