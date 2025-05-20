import 'package:flutter/material.dart';
import 'MenuDrawer.dart';
import 'user_info/email_verification_page.dart';

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
    setState(() {
      if (!_showChat) _showChat = true;
      _messages.add({'role': 'user', 'text': question});
      _messages.add({'role': 'bot', 'text': '이것은 "$question"에 대한 임시 답변입니다.'});
      _controller.clear();
    });
    // 스크롤을 맨 아래로 이동
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
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
                              onPressed: () {},
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
                      ],
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
                        onSubmitted: (_) => _search(),
                        decoration: InputDecoration(
                          hintText: '무엇이든 부탁하세요',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
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
                      onPressed: _search,
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
