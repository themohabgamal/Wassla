import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/user.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final _currentUser = ChatUser(id: '1', firstName: "You");
  final _bot = ChatUser(id: '2', firstName: "Broxi");
  List<ChatMessage> messages = <ChatMessage>[];
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 5),
      ),
      enableLog: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Broxi',
          style: FontHelper.poppins24Bold(),
        ),
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          currentUserContainerColor: MyTheme.mainColor,
          containerColor: Colors.grey.shade300,
        ),
        currentUser: _currentUser,
        onSend: (message) {
          getChatResponse(message);
        },
        messages: messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
    });
    List<Map<String, dynamic>> messagesHistory =
        messages.reversed.map((message) {
      if (message.user == _currentUser) {
        return {
          'role': 'user', // Convert enum to string
          'content': message.text,
        };
      } else {
        return {
          'role': 'assistant', // Convert enum to string
          'content': message.text,
        };
      }
    }).toList();

    final request = ChatCompleteText(
        model: GptTurbo0631Model(), messages: messagesHistory, maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print(element.message!.content);
      if (element.message != null) {
        setState(() {
          messages.insert(
              0,
              ChatMessage(
                text: element.message!.content,
                user: _bot,
                createdAt: DateTime.now(),
              ));
        });
      }
    }
  }
}
