# bot_interceptor

Fighttech Flutter Image Widget
- https://pub.dev/packages/bot_interceptor 

# 1. Features

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

# 2. How to create bot Telegram and use API

## Step 1: Create new bot
- Open telegram -> search "BotFather" and enter message: "/newbot"

![create_new](./doc/1.create_new.png)

## Step 2: Enter bot name

![enter_name](./doc/2.enter_name.png)

## Step 3: Enter username
- Enter username your bot.  It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.

![create_new](./doc/3.enter_username.png)

## Step 4: Start bot
- Open your bot

![create_new](./doc/4.1.open_your_bot.png)

- Start bot

![create_new](./doc/4.2.start_bot.png)

## Step 5: Get all bot
![create_new](./doc/5.get_all_my_bot.png)

## Step 6: Open bot setting and get API TOKEN
- Select your bot and choose API TOKEN                                                                                                                                                     
![create_new](./doc/6.bot_setting.png)

## Step 7: Add bot to group
![create_new](./doc/7.add_bot_to_group.png)

## Step 8: Get group id
![create_new](./doc/8.get_group_id.png)

## Step 9: Test send message
![create_new](./doc/9.test_send_message.png)

## Curl

```
curl --location --request GET 'https://api.telegram.org/bot<API_TOKEN>/sendMessage?chat_id=<GROUP_ID>&text=helloworld'
```