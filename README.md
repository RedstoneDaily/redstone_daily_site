# redstone_daily_site

A new Flutter project.

## Getting Started

content_list.dart:
```
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: 'localhost');
    Uri uri = Uri.http(apiHost, '/daily', {
      'yy': widget.year,
      'mm': widget.month,
      'dd': widget.day,
    });

    try {
      final response = await http.get(uri);
```
前端需要dart-define一个环境变量来决定发起api请求的url使用哪个域名
默认值是localhost(方便在电脑上同时开前后端调试)
然后如果要换一个自定义的源就设置一个值

```
- run: flutter build web --web-renderer canvaskit --dart-define API_HOST=redstonedaily.top
```
测试和生产环境的CD都会把它定义成redstonedaily.top
