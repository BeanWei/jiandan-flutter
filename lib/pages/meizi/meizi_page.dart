import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jiandan/common/no_network_view.dart';
import 'package:jiandan/common/error_view.dart';
import 'package:jiandan/common/config.dart';
import 'package:jiandan/api/api_uri.dart';
import 'package:jiandan/models/meizi.dart';

class MeiziPage extends StatefulWidget {
  @override
  _MeiziPageState createState() => _MeiziPageState();
}

class _MeiziPageState extends State<MeiziPage> {
  //List<MeiZi> meiziList = [];
  List meiziList = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  String _scrollDistanceIdentifier;

  int _page;
  bool isError = false;
  ScrollController _scrollController;

  double scrollDistance = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollDistanceIdentifier = 'scrollDistanceIndentifier';
    _page = PageStorage
            .of(context)
            .readState(context) ?? 1;
    scrollDistance = PageStorage
            .of(context)
            .readState(context) ?? 0.0;
    meiziList.addAll(PageStorage
                  .of(context)
                  .readState(context) ??
        []);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = ScrollController();

    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getData(false);
    }
    scrollDistance = _scrollController.position.pixels;
    PageStorage.of(context).writeState(context, scrollDistance,
        identifier: _scrollDistanceIdentifier);
    setState(() {});
  }

  Future<Null> _handleRefresh() {
    return getData(true);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_handleScroll);
    super.dispose();
  }

  Widget _buildFloatActionButton() {
    double screenHeight = MediaQuery.of(context).size.height;
    if (scrollDistance > screenHeight / 2) {
      return FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 300),
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
    if (meiziList.isEmpty) {
      if (!networkEnable) {
        return NoNetworkView();
      } else if (isError) {
        return ErrorView();
      } else {
        getData(true);
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return StaggeredGridView.countBuilder(
        controller: _scrollController,
        padding: const EdgeInsets.all(1.0),
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        mainAxisSpacing: 1.0,
        itemCount: meiziList.length,
        crossAxisSpacing: 1.0,
        itemBuilder: (BuildContext context, int index) =>
            _buildImageItem(meiziList.elementAt(index)),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new RefreshIndicator(
          key: _refreshIndicatorKey,
          child: _buildRefreshContent(),
          onRefresh: _handleRefresh),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  Future<Null> getData(bool isClean) async {
    if (!networkEnable) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('网络开小差了X﹏X')));
      return;
    }
    if (isClean) {
      _page = 1;
    }
    Dio dio = new Dio();
    String url = ApiUri.MeiZi_List.replaceFirst('@page', _page.toString());
    Response response = await dio.get(url);
    MeiZi meizi = MeiZi.fromJson(response.data);
    _page++;
    if (isClean) {
      meiziList.clear();
    } else {}
    var comments = meizi.comments;
    for (var comment in comments) {
      var pics = comment.pics;
      for (var p in pics) {
        meiziList.add(p);
      }
    }
    setState(() {});
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