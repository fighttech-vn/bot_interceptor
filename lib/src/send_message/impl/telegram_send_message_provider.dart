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
          parseMode: ParseMode.markdownV2,
        );
      } else {
        final count = message.length ~/ BotInterceptorConstants.limitCharacter;

        for (var i = 0; i < count; i++) {
          final start = BotInterceptorConstants.limitCharacter * i;

          await _bot.sendMessage(
            ChatID(chatId),
            '''
${i != 0 ? '<code>' : ''}
${message.substring(start, start + BotInterceptorConstants.limitCharacter)}
</code>
            ''',
            parseMode: ParseMode.markdownV2,
          );
        }

        await _bot.sendMessage(
          ChatID(chatId),
          '''
<code>
${message.substring(BotInterceptorConstants.limitCharacter * count, message.length)}
</code>
            ''',
          parseMode: ParseMode.markdownV2,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
