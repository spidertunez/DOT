import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  String typingContent = '';

  String selectedStyle = "شرح أكاديمي";
  final List<String> styles = ["شرح أكاديمي", "شرح مبسط", "مثال واقعي", "كود مباشر"];

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[؀-ۿ]');
    return arabicRegex.hasMatch(text);
  }

  Future<void> sendMessage(String userInput) async {
    setState(() {
      messages.add({"role": "user", "content": userInput});
      isLoading = true;
      typingContent = '';
    });
    scrollToBottom();

    String stylePrompt = "";
    if (selectedStyle == "شرح أكاديمي") {
      stylePrompt = "اشرح كأنك أستاذ جامعي يشرح مفاهيم البرمجة بشكل رسمي ودقيق.";
    } else if (selectedStyle == "شرح مبسط") {
      stylePrompt = "اشرح الفكرة بطريقة بسيطة وسهلة الفهم، وابتعد عن المصطلحات المعقدة.";
    } else if (selectedStyle == "مثال واقعي") {
      stylePrompt = "اشرح عن طريق تشبيه أو مثال من الحياة الواقعية يوضح فكرة البرمجة.";
    } else if (selectedStyle == "كود مباشر") {
      stylePrompt = "أعطني كود مباشر فقط بدون شرح طويل، وركز على الجانب العملي.";
    }

    final apiKey = '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';
    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final body = jsonEncode({
      "model": "deepseek/deepseek-r1-zero:free",
      "messages": [
        {
          "role": "system",
          "content": "أنت مساعد برمجي ذكي. جاوب بنفس اللغة التي يستخدمها المستخدم سواء كانت العربية أو الإنجليزية، وطبق هذا التوجيه في أسلوب الرد أنت مساعد برمجة متمكن في كل من العربية والإنجليزية. يجب أن تتمكن من الرد على الأسئلة المتعلقة بالبرمجة بأي من اللغتين، حسب تفضيل المستخدم. تشمل مهامك : لغات البرمجة (مثل بايثون، جافا سكربت، جافا، سي++، وغيرها) و كتابة وتصحيح الأكواد و شرح المفاهيم البرمجية (مثل الحلقات، الشروط، البرمجة الكائنية، وغيرها). و تقديم نصائح حول أفضل الممارسات ومعايير البرمجة. و مساعدة في مشاكل هياكل البيانات والخوارزميات. و تقديم موارد تعليمية وتوصيات للدراسة المتقدمة. و مساعدة في رسائل الأخطاء وتصحيح المشاكل. و تقديم تفسيرات واضحة ومفصلة لأي استفسار متعلق بالبرمجة، مع تبسيط المواضيع المعقدة.: $stylePrompt"
        },
        {
          "role": "user",
          "content": userInput,
        }
      ]
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://yourwebsite.com',
        'X-Title': 'DeepSeek R1 Zero Chat App',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final content = responseData['choices'][0]['message']['content'];
      animateTyping(content);
    } else {
      setState(() {
        isLoading = false;
      });
      print('❌ Status: ${response.statusCode}');
      print('❌ Body: ${response.body}');
      throw Exception('Failed to fetch response');
    }
  }

  void animateTyping(String fullText) async {
    for (int i = 0; i <= fullText.length; i++) {
      await Future.delayed(Duration(milliseconds: 30));
      setState(() {
        typingContent = fullText.substring(0, i);
      });
      scrollToBottom();
    }
    setState(() {
      messages.add({"role": "assistant", "content": typingContent});
      isLoading = false;
      typingContent = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("DeepSeek R1 Zero Chat"),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStyle,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.deepPurple[100],
              onChanged: (value) {
                setState(() {
                  selectedStyle = value!;
                });
              },
              items: styles.map((style) {
                return DropdownMenuItem(
                  value: style,
                  child: Text(style),
                );
              }).toList(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(12),
              itemCount: messages.length + (typingContent.isNotEmpty ? 1 : 0),
              itemBuilder: (context, index) {
                String content = '';
                bool isUser = false;
                if (index == messages.length && typingContent.isNotEmpty) {
                  content = typingContent;
                  isUser = false;
                } else {
                  final msg = messages[index];
                  content = msg['content'] ?? '';
                  isUser = msg['role'] == 'user';
                }
                final dir = isArabic(content) ? TextDirection.rtl : TextDirection.ltr;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.deepPurple[100] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Directionality(
                      textDirection: dir,
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 16,
                          color: isUser ? Colors.black : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "اكتب رسالتك...",
                      hintStyle: TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _controller.clear();
                        sendMessage(value.trim());
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final input = _controller.text.trim();
                      if (input.isNotEmpty) {
                        _controller.clear();
                        sendMessage(input);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
