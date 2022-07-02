// Copyright 2022 Fighttech.vn, Ltd. All rights reserved.

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

String prettyJsonStr(Map<dynamic, dynamic> json) {
  final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
  return encoder.convert(json);
}

class LoggerInterceptor extends Interceptor {
  final Function(DioError)? onRequestError;
  final bool Function(Response<dynamic>)? ignoreReponseDataLog;

  LoggerInterceptor({
    this.onRequestError,
    this.ignoreReponseDataLog,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(prettyJsonStr(
      {
        'from': 'onRequest',
        'Time': DateTime.now().toString(),
        'baseUrl': options.baseUrl,
        'path': options.path,
        'headers': options.headers,
        'method': options.method,
        'requestData': options.data,
        'queryParameters': options.queryParameters,
      },
    ));
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    log(prettyJsonStr({
      'from': 'onResponse',
      'Time': DateTime.now().toString(),
      'statusCode': response.statusCode,
      'baseUrl': response.requestOptions.baseUrl,
      'path': response.requestOptions.path,
      'method': response.requestOptions.method,
      if (ignoreReponseDataLog?.call(response) != false)
        'responseData': response.data,
    }));

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(prettyJsonStr({
      'from': 'onError',
      'Time': DateTime.now().toString(),
      'baseUrl': err.requestOptions.baseUrl,
      'header': err.requestOptions.headers,
      'path': err.requestOptions.path,
      'type': err.type,
      'message': err.message,
      'statusCode': err.response?.statusCode,
      'error': err.error,
      'responseData': err.requestOptions.data
    }));
    super.onError(err, handler);
  }
}
