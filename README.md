# redstone_daily_site

[项目介绍](https://github.com/RedstoneDaily/redstone_daily)
这是它的前端

## 注意事项

flutter build之前执行一下prebuild.sh谢谢喵
```
./prebuild.sh && flutter build web --web-renderer canvaskit
```
传递`--aegis-enabled`参数，页面将启用aegis观测
```
./prebuild.sh --aegis-enabled && flutter build web --web-renderer canvaskit
```
启用aegis观测需要往index.html里插入html片段（是一些script标签引入&执行脚本，内容从web/aegis-script.html读取）

所以index.html现在是生成性文件，prebuild.sh将以web/template.html为模板，将其中的`${AEGIS_SCRIPT}`替换为对应html片段（或空，如果不启用aegis），生成index.html.

修改页面html内容请在template.html里修改

---

content_list.dart:
```
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: '');
    Uri uri = apiHost != ''
        ? Uri.https(apiHost, '/api/daily', {
            'yy': widget.year,
            'mm': widget.month,
            'dd': widget.day,
          })
        : Uri.parse('/api/daily?yy=${widget.year}&mm=${widget.month}&dd=${widget.day}');
```
dart-define变量`API_HOST`应决定发起api请求时的目标域名

默认值统一为空字符串，如需控制目标域名请在flutter cli里dart-define设置此变量

如果未定义或为空字符串，则发起api请求时应不设定域名——此时api请求将有可能使用cdn的域名，以实现缓存

cd-test.yml:
```
- run: prebuild.sh && flutter build web --web-renderer canvaskit --dart-define API_HOST=redstonedaily.top
```
测试的CD会将它定义成redstonedaily.top；生产环境不定义

---

另：web渲染引擎需设置为canvaskit才能清晰显示主页里的那些低清像素画的mc物品图片，否则会模糊