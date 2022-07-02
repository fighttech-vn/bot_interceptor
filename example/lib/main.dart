import 'dart:developer';

import 'package:bot_interceptor/bot_interceptor.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  try {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://randomuser.me/',
        responseType: ResponseType.json,
      ),
    )..interceptors.add(LoggerInterceptor());
    final response = await dio.get('api/');
    log(response.data);
  } catch (e) {
    log(e.toString());
  }
}
