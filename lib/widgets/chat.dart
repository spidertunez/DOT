import 'package:flutter/material.dart';
import 'package:hom/theme/Appcolors.dart';

class ChatDialog extends StatefulWidget {
  const ChatDialog({super.key});

  @override
  State<ChatDialog> createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _typeIndicatorController;
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! How can I help you with your learning journey today?',
      'isUser': false,
      'time': '12:30 PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _typeIndicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    // Adding slight delay before showing keyboard
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typeIndicatorController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final now = DateTime.now();
    final timeString = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isUser': true,
        'time': timeString,
      });
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });

    // Show typing indicator
    setState(() {
      _isTyping = true;
    });

    // Simulate bot response after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        _isTyping = false;
        _messages.add({
          'text': _generateResponse(_messageController.text),
          'isUser': false,
          'time': '${now.hour}:${(now.minute + 1).toString().padLeft(2, '0')}',
        });
      });

      // Scroll to bottom after adding new message
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _generateResponse(String message) {
    // Simple response generator based on message content
    if (message.toLowerCase().contains('course') ||
        message.toLowerCase().contains('learn')) {
      return 'We have many excellent courses! Do you prefer web development, mobile app development, or data science courses?';
    } else if (message.toLowerCase().contains('thank')) {
      return 'Happy to help! Is there anything else you need?';
    } else if (message.toLowerCase().contains('help')) {
      return 'Of course! I can help you find courses that suit your needs, track your progress, or answer your questions about the platform.';
    } else {
      return 'Thanks for your message! Do you need help with a specific learning path or finding particular courses?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.9, end: 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.navyBlue,
                    Color(0xFF1D3557), // Deeper navy blue for better contrast
                  ],
                  stops: [0.1, 0.9],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // Messages List
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background pattern
                          CustomPaint(
                            painter: ChatBackgroundPainter(),
                            size: Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * 0.6,
                            ),
                          ),

                          // Messages
                          ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              16,
                              16,
                              80,
                            ), // Extra padding for typing indicator
                            itemCount: _messages.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return _buildMessageBubble(message);
                            },
                          ),

                          // Typing indicator
                          if (_isTyping)
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: _buildTypingIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Input Area
                  _buildInputArea(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.navyBlue.withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.beige.withOpacity(0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.beige.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.smart_toy,
                        color: AppColors.offWhite,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Smart Assistant',
                    style: TextStyle(
                      color: AppColors.offWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(radius: 4, backgroundColor: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        'Online now',
                        style: TextStyle(color: AppColors.beige, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: AppColors.offWhite),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.offWhite),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, top: 4),
        child: Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser)
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppColors.beige.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.smart_toy,
                  color: AppColors.offWhite,
                  size: 14,
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.beige.withOpacity(0.9)
                    : AppColors.lightBlue.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isUser
                      ? const Radius.circular(18)
                      : const Radius.circular(4),
                  bottomRight: isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkGray.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'] as String,
                    style: TextStyle(
                      color: isUser ? AppColors.darkGray : AppColors.offWhite,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message['time'] as String,
                      style: TextStyle(
                        color: isUser
                            ? AppColors.darkGray.withOpacity(0.6)
                            : AppColors.offWhite.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isUser)
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(left: 8),
                decoration: const BoxDecoration(
                  color: AppColors.beige,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    "N",
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _typeIndicatorController,
            builder: (context, child) {
              return Row(
                children: [
                  _buildDot(_typeIndicatorController.value - 0.3),
                  const SizedBox(width: 3),
                  _buildDot(_typeIndicatorController.value - 0.15),
                  const SizedBox(width: 3),
                  _buildDot(_typeIndicatorController.value),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDot(double animValue) {
    double size = 6 +
        (4 *
            (animValue < 0
                ? 0
                : animValue > 1
                    ? 1
                    : animValue));

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.offWhite.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.offWhite),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: AppColors.offWhite),
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(
                  color: AppColors.offWhite.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.darkGray.withOpacity(0.3),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.beige.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: AppColors.navyBlue,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Custom painter for the chat background
class ChatBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.beige.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Draw some subtle background elements
    for (int i = 0; i < 5; i++) {
      double x = size.width * (i / 5);
      double y = size.height * 0.2 * i;
      double radius = 80 + (i * 30);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Draw a subtle pattern
    final patternPaint = Paint()
      ..color = AppColors.lightBlue.withOpacity(0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 10; i++) {
      final path = Path();
      path.moveTo(0, size.height * i / 10);
      path.lineTo(size.width, size.height * (i + 5) / 10);
      canvas.drawPath(path, patternPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
