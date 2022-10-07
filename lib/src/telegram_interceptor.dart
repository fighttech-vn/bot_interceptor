import 'dart:convert';

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
    _projectName = projectId != null ? '#${projectId!}' : '';
    _projectName = '${_projectName!} ${const Uuid().v4()}';
  }

  late TelegramSendMessageProvider _messageProvider;
  String? _projectName;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final formData = options.data;
    var formDataText = options.data;
    
    if (formData is FormData) {
      formDataText = jsonEncode(formData.fields.map((e) => e).toList());
      formDataText = formDataText + jsonEncode(formData.files.map((e) => e.value.filename).toList());
    }

    _messageProvider.send(
      message: '''
$_projectName
<code>{
   'from': 'onRequest',
        'Time': ${DateTime.now().toString()},
        'statusCode': ${options.data},
        'baseUrl': ${options.baseUrl},
        'path': ${options.path},
        'header': ${options.headers},
        'queryParameters': ${options.queryParameters},
        'headers': ${options.headers},
        'method': ${options.method},
        'requestData': $formDataText,
}</code>
    ''',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (willSendSuccess) {
      _messageProvider.send(
        message: '''
$_projectName
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
    _messageProvider.send(
      message: '''
$_projectName
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
