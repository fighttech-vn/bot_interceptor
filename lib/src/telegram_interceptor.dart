import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'send_message/impl/telegram_send_message_provider.dart';

class TelegramInterceptor extends Interceptor {
  final String token;
  final int chatId;
  final String? projectId;
  final bool willSendSuccess;

  TelegramInterceptor({
    required this.token,
    required this.chatId,
    this.projectId,
    this.willSendSuccess = false,
  }) {
    _messageProvider = TelegramSendMessageProvider(
      token: token,
      chatId: chatId,
    );
  }

  late TelegramSendMessageProvider _messageProvider;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final projectName = projectId != null ? '#${projectId!}' : '';

    if (willSendSuccess) {
      _messageProvider.send(
        message: '''
$projectName ${const Uuid().v4()}
<code>{
  'from': 'onResponse',
  'Time': ${DateTime.now().toString()},
  'baseUrl': '${response.requestOptions.baseUrl}',
  'path': ${response.requestOptions.path},
  'path': ${response.requestOptions.path},
  'method': ${response.requestOptions.method},
   'responseData': ${response.data},
}</code>
    ''',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final projectName = projectId != null ? '#${projectId!}' : '';

    _messageProvider.send(
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
