import 'dart:developer';

import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:dart_telegram_bot/telegram_entities.dart';

import '../send_message_provider.dart';

class TelegramSendMessageProvider extends SendMessageProvider {
  final int chatId;
  final String token;

  TelegramSendMessageProvider({
    required this.chatId,
    required this.token,
  }) : _bot = Bot(token: token);

  final Bot _bot;

  @override
  Future<void> send({required String message}) async {
    try {
      if (message.length < 4000) {
        await _bot.sendMessage(
          ChatID(chatId),
          message,
          parseMode: ParseMode.html,
        );
      } else {
        await _bot.sendMessage(
          ChatID(chatId),
          message.substring(0, 3999),
          parseMode: ParseMode.html,
        );
        await _bot.sendMessage(
          ChatID(chatId),
          message.substring(4000, message.length - 1),
          parseMode: ParseMode.html,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
