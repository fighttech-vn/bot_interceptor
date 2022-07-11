import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:dart_telegram_bot/telegram_entities.dart';

import '../send_message_provider.dart';

class TelegramSendMessageProvider extends SendMessageProvider {
  final int chatId;
  final String token;

  TelegramSendMessageProvider({required this.chatId, required this.token})
      : _bot = Bot(token: token);

  final Bot _bot;

  @override
  Future<void> send({required String message}) async {
    try {
      await _bot.sendMessage(
        ChatID(chatId),
        message,
        parseMode: ParseMode.html,
      );
    } catch (_) {}
  }
}
