import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'logger_interceptor.dart';
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
    _projectName = projectId != null ? projectId! : '';
    _projectName = '${_projectName!} ${const Uuid().v4()}';
  }

  late TelegramSendMessageProvider _messageProvider;
  String? _projectName;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final formData = options.data;
    String formDataText = '';

    if (formData is FormData) {
      try {
        formDataText = jsonEncode(formData.fields.map((e) => e).toList());
      } catch (e) {
        log('[bot_interceptor]--->');
        log(e.toString());
      }
      try {
        formDataText = formDataText +
            jsonEncode(formData.files
                .map((e) => {
                      'key': e.key,
                      'name': e.value.filename,
                    })
                .toList());
      } catch (e) {
        log('[bot_interceptor]--->');
        log(e.toString());
      }
    }
    final json = prettyJsonStr({
      'from': 'onRequest',
      'Time': DateTime.now().toString(),
      'statusCode': options.data,
      'baseUrl': options.baseUrl,
      'path': options.path,
      'queryParameters': options.queryParameters,
      'headers': options.headers,
      'method': options.method,
      'requestData':
          formDataText.isNotEmpty ? formDataText : options.data?.toString(),
    });
    _messageProvider.send(
      message: '''$_projectName
<code>
$json
</code>
    ''',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (willSendSuccess) {
      final json = prettyJsonStr({
        'from': 'onResponse',
        'Time': DateTime.now().toString(),
        'baseUrl': response.requestOptions.baseUrl,
        'path': response.requestOptions.path,
        'method': response.requestOptions.method,
        'responseData': response.data,
      });
      _messageProvider.send(
        message: '''
$_projectName
<code>
$json
</code>
    ''',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final json = prettyJsonStr({
      'from': 'onError',
      'Time': DateTime.now().toString(),
      'baseUrl': err.requestOptions.baseUrl,
      'header': err.requestOptions.headers,
      'path': err.requestOptions.path,
      'type': err.type,
      'message': err.message,
      'statusCode': err.response?.statusCode,
      'error': err.error,
      'requestOptionsData': err.requestOptions.data,
      'responseData': err.response?.data,
      'raw': err.toString()
    });
    _messageProvider.send(
      message: '''
$_projectName
<code>
$json
</code>
    ''',
    );

    super.onError(err, handler);
  }
}
