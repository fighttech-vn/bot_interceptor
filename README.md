# bot_interceptor

Fighttech Flutter Image Widget
- https://pub.dev/packages/bot_interceptor 

## Features

 - [x] Support Telegram bot 
 - [ ] Slack bot restful API
 
 # Example
 
 ```
 Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(LoggerInterceptor())
      ..interceptors.add(
        TelegramInterceptor(
          chatId: <chat_id: int>,
          token: <token: string>,
          projectId: <project_id>,
        ),
      ),
      );
	  
```
