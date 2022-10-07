import 'package:bot_interceptor/bot_interceptor.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  try {
    final dio = Dio()
      ..interceptors.add(LoggerInterceptor())
      ..interceptors.add(TelegramInterceptor(
        chatId: -1001797544571,
        token: '5482069008:AAE_kh5NpX4Z88ONdvyWN3U335flPF6X6_M',
        projectId: 'wiki',
        willSendSuccess: true,
      ));
    var response = await dio.get('https://randomuser.me/api/');
    print(response);
  } catch (e) {
    print(e);
  }
}
