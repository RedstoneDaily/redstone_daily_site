# redstone_daily_site

[项目介绍](https://github.com/RedstoneDaily/redstone_daily)
这是它的前端

## 注意事项

flutter build之前执行一下prebuild.sh谢谢喵
```
prebuild.sh && flutter build web --web-renderer canvaskit
```
给`--aegis-enabled`参数可以启用aegis观测
```
prebuild.sh --aegis-enabled && flutter build web --web-renderer canvaskit
```

content_list.dart:
```
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: 'redstonedaily.top');
    Uri uri = Uri.http(apiHost, '/daily', {
      'yy': widget.year,
      'mm': widget.month,
      'dd': widget.day,
    });

    try {
      final response = await http.get(uri);
```
前端需要dart-define一个环境变量来决定发起api请求的url使用哪个域名
默认值是redstonedaily.top
然后如果要换一个自定义的源就设置一个值

```
- run: prebuild.sh && flutter build web --web-renderer canvaskit --dart-define API_HOST=redstonedaily.top
```
测试和生产环境的CD都会把它定义成redstonedaily.top

另：渲染引擎设置为canvaskit才能清晰显示低清像素画mc物品图片，否则会模糊