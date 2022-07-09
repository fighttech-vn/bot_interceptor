# How to create bot Telegram and use API

## Step 1: Create new bot
- Open telegram -> search "BotFather" and enter message: "/newbot"

![create_new](./1.create_new.png)

## Step 2: Enter bot name

![enter_name](./2.enter_name.png)

## Step 3: Enter username
- Enter username your bot.  It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.

![create_new](./3.enter_username.png)

## Step 4: Start bot
- Open your bot

![create_new](./4.1.open_your_bot.png)

- Start bot

![create_new](./4.2.start_bot.png)

## Step 5: Get all bot
![create_new](./5.get_all_my_bot.png)

## Step 6: Open bot setting and get API TOKEN
- Select your bot and choose API TOKEN                                                                                                                                                     
![create_new](./6.bot_setting.png)

## Step 7: Add bot to group
![create_new](./7.add_bot_to_group.png)

## Step 8: Get group id
![create_new](./8.get_group_id.png)

## Step 9: Test send message
![create_new](./9.test_send_message.png)

## Curl

```
curl --location --request GET 'https://api.telegram.org/bot<API_TOKEN>/sendMessage?chat_id=<GROUP_ID>&text=helloworld'
```