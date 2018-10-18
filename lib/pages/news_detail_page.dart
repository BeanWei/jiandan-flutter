import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jiandan/api/Api.dart';

class NewsDetailPage extends StatefulWidget {

  String url;

  NewsDetailPage({Key key, this.url}):super(key: key);

  @override
  State<StatefulWidget> createState() => new NewsDetailPageState(url: this.url);
}

class NewsDetailPageState extends State<NewsDetailPage> {
  String url;
  bool loaded = false;
  String detailDataStr;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  NewsDetailPageState({Key key, this.url});

  @override
  void initState() {
    super.initState();
    //监听WebView的加载事件
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        //加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text("资讯详情", style: new TextStyle(color: Colors.white),));
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0,));
    return new WebviewScaffold(
      //url: JianDanApis['news_detail'].replaceFirst('@id', this.id.toString()),
      url: this.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}