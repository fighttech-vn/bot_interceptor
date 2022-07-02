# Example LoggerInterceptor

```
final dio = Dio(
      BaseOptions(
        baseUrl: 'https://randomuser.me/',
        responseType: ResponseType.json,
      ),
    )..interceptors.add(LoggerInterceptor());
```