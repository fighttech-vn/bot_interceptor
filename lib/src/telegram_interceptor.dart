import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'send_message/impl/telegram_send_message_provider.dart';

class TelegramInterceptor extends Interceptor {
  final String token;
  final int chatId;
  final String? projectId;

  TelegramInterceptor({
    required this.token,
    required this.chatId,
    this.projectId,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final bot = TelegramSendMessageProvider(
      token: token,
      chatId: chatId,
    );
    final projectName = projectId != null ? '#${projectId!}' : '';
    bot.sendError(
      message: '''
$projectName ${const Uuid().v4()}
<code>{
  'from': 'onError',
  'Time': ${DateTime.now().toString()},
  'baseUrl': ${err.requestOptions.baseUrl},
  'header': ${err.requestOptions.headers},
  'path': ${err.requestOptions.path},
  'type': ${err.type},
  'message': ${err.message},
  'statusCode': ${err.response?.statusCode},
  'error': ${err.error},
  'responseData': ${err.requestOptions.data},
  'raw': ${err.toString()}
}</code>
    ''',
    );
    super.onError(err, handler);
  }
}
