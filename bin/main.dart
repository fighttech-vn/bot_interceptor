import 'package:bot_interceptor/bot_interceptor.dart';

void main() {
  print(prettyJsonStr(
    {
      'from': 'onRequest',
      'Time': DateTime.now().toString(),
    },
  ));
}
