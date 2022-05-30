import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:dart_telegram_bot/telegram_entities.dart';

import '../bot_interceptor.dart';

class TelegramBotInterceptor extends BotInterceptor {
  final int chatId;
  final String token;
  final Bot _bot;

  TelegramBotInterceptor({required this.chatId, required this.token})
      : _bot = Bot(token: token);

  @override
  Future<void> sendErrorMessage({required String message}) async {
    try {
      await _bot.sendMessage(
        ChatID(chatId),
        message,
        parseMode: ParseMode.html,
      );
    } catch (_) {}
  }
}
