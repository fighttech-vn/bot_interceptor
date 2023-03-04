import 'dart:developer';

import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:dart_telegram_bot/telegram_entities.dart';

import '../../bot_interceptor_constants.dart';
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
      if (message.length < BotInterceptorConstants.limitCharacter) {
        await _bot.sendMessage(
          ChatID(chatId),
          message,
          parseMode: ParseMode.html,
        );
      } else {
        final count = message.length ~/ BotInterceptorConstants.limitCharacter;

        for (var i = 0; i < count; i++) {
          final start = BotInterceptorConstants.limitCharacter * i;

          await _bot.sendMessage(
            ChatID(chatId),
            message.substring(
                start, start + BotInterceptorConstants.limitCharacter),
            parseMode: ParseMode.html,
          );
        }

        await _bot.sendMessage(
          ChatID(chatId),
          message.substring(
              BotInterceptorConstants.limitCharacter * count, message.length),
          parseMode: ParseMode.html,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
