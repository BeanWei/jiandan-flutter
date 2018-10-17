import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiandan/common/no_network_view.dart';
import 'package:jiandan/common/error_view.dart';
import 'package:jiandan/common/config.dart';
import 'package:jiandan/api/Api.dart';
import 'package:jiandan/models/meizi.dart';
import 'package:jiandan/models/duanzi.dart';
import 'package:jiandan/models/wuliao.dart';
import 'package:jiandan/models/news.dart';

class ItemListPage extends StatefulWidget {
  final String item;

  ItemListPage({Key key, @required this.item})
      : super(key: key);

  @override
  _ItemListPageState createState() => new _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {

  List JDContentList = [];

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  String _pageIdentifier;
  String _dataIdentifier;
  String _scrollDistanceIdentifier;

  int _page;

  ScrollController _scrollController;

  double scrollDistance = 0.0;

  bool isError = false;
  bool isLoading = false;

  CancelToken _token = new CancelToken();

  @override
  void initState() {
    super.initState();

    _pageIdentifier = '${widget.item}_pageIdentifier';
    _dataIdentifier = '${widget.item}_dataIdentifier';
    _scrollDistanceIdentifier = '${widget.item}_scrollDistanceIndentifier';
    scrollDistance = PageStorage.of(context).readState(context,identifier: _scrollDistanceIdentifier)??0.0;

    _page =
        PageStorage.of(context).readState(context, identifier: _pageIdentifier);
    JDContentList.addAll(PageStorage
        .of(context)
        .readState(context, identifier: _dataIdentifier) ??
    []);

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  Future<Null> _handleRefresh() {
    return getData(true, widget.item);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_handleScroll);
    _token?.cancel();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getData(false, widget.item);
    }
    scrollDistance = _scrollController.position.pixels;
    PageStorage.of(context).writeState(context, scrollDistance,identifier: _scrollDistanceIdentifier);
    setState(() {});
  }

  Widget _buildFloatActionButton() {
    double screenHeight = MediaQuery.of(context).size.height;
    if (scrollDistance > screenHeight / 2) {
      return FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(0.0,
              duration: Duration(
                  milliseconds: 300),
              curve: Curves.easeOut);
        },
        tooltip: 'top',
        child: new Icon(Icons.arrow_upward),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          _refreshIndicatorKey.currentState.show();
        },
        tooltip: 'refresh',
        child: new Icon(Icons.refresh),
      );
    }
  }

  Widget _buildRefreshContent() {
    if (JDContentList.isEmpty) {
      if (!networkEnable) {
        return NoNetworkView();
      } else if (isError) {
        return ErrorView();
      } else {
        getData(true, widget.item);
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return ListView.builder(
          controller: _scrollController,
          itemCount: JDContentList.length,
          itemBuilder: (BuildContext context, int index) {
            if (JDContentList.elementAt(index).type == '福利') {
              return _buildImageItem(JDContentList.elementAt(index).url);
            } else {
              //return _buildTextItem(JDContentList.elementAt(index));
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _globalKey,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        child: _buildRefreshContent(),
        onRefresh: _handleRefresh,
      ),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  Future<Null> launcherUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> getData(bool isClean, String item) async {
    if (!networkEnable) {
      _globalKey.currentState.showSnackBar(SnackBar(content: Text('网络开小差了X﹏X')));
      return;
    }
    if (isClean) {
      _page = 1;
    }
    Dio dio = new Dio();
    String url = JianDanApis[item].replaceFirst('@page', _page.toString());
    Response response = await dio.get(url, cancelToken: _token).catchError((DioError error) {
      if (!CancelToken.isCancel(error)) {
        isError = true;
      }
    });
    _page++;
    if (isClean) {
      JDContentList.clear();
    }
    switch (item) {
      case "妹子图":
        MeiZi itemData = MeiZi.fromJson(response.data);
        for (var comment in itemData.comments) {
          for (var p in comment.pics) {
            JDContentList.add(p);
          }
        }
        break;
      case "无聊图":
        WuLiao itemData = WuLiao.fromJson(response.data);
        for (var comment in itemData.comments) {
          for (var p in comment.pics) {
            JDContentList.add(p);
          }
        }
        break;
      case "段子手":
        DuanZi itemData = DuanZi.fromJson(response.data);
        for (var comment in itemData.comments) {
          JDContentList.add(comment.text_content);
        }
        break;
      case "新鲜事":
        News itemData = News.fromJson(response.data);
        for (var comment in itemData.posts) {
          JDContentList.add(comment.title);
        }
        break;
      default:
        News itemData = News.fromJson(response.data);
        for (var comment in itemData.posts) {
          JDContentList.add(comment.title);
        }
    }

    setState(() {});
  }

  Widget _buildTextItem() {
    //todo: add the text view
  }

  Widget _buildImageItem(String picurl) {
    //String picurl = comments.pics;
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new ImagePreViewWidget(url: picurl),
            )
        );
      },
      child: new Hero(tag: picurl, child: CachedNetworkImage(imageUrl: picurl)),
    );
  }

}


class ImagePreViewWidget extends StatelessWidget {
  final String url;

  const ImagePreViewWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: url,
            child: CachedNetworkImage(imageUrl: url),
          ),
        ),
      ),
    );
  }
}