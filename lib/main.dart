import 'package:flutter/material.dart';

void main() {
  runApp(const JiZhangApp());
}

class JiZhangApp extends StatelessWidget {
  const JiZhangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '记账助手',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [
    '欢迎使用记账助手！🎉',
    '请输入您的消费，例如："早餐花了15块"',
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    final userMessage = _controller.text.trim();
    setState(() {
      _messages.add('您：$userMessage');
      _messages.add('助手：已记录 💰 ${_extractAmount(userMessage)}元');
    });
    
    _controller.clear();
  }

  String _extractAmount(String message) {
    final regex = RegExp(r'(\d+\.?\d*)');
    final match = regex.firstMatch(message);
    return match?.group(1) ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('记账助手'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index].startsWith('您：');
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.green[100] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _messages[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '说说你的消费...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('发送'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
