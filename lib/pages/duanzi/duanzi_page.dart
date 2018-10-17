import 'dart:async';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jiandan/api/api_uri.dart';
import 'package:jiandan/common/no_network_view.dart';
import 'package:jiandan/common/error_view.dart';
import 'package:jiandan/common/config.dart';
import 'package:jiandan/models/duanzi.dart';


class DuanziPage extends StatefulWidget {
  @override
  _DuanziPageState createState() => _DuanziPageState();
}

class _DuanziPageState extends State<DuanziPage> {
  List<Comments> duanziList = [];

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
    duanziList.addAll(PageStorage
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

  Widget _actionRow(DuanZi duanzi) => Padding(
    padding: const EdgeInsets.only(right: 50.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.thumbsUp,
          size: 15.0,
          color: Colors.grey,
        ),
        Icon(
          FontAwesomeIcons.thumbsDown,
          size: 15.0,
          color: Colors.grey,
        ),
        Icon(
          FontAwesomeIcons.comments,
          size: 15.0,
          color: Colors.grey,
        ),
        Icon(
          FontAwesomeIcons.share,
          size: 15.0,
          color: Colors.grey,
        ),
      ]
    ),
  );

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
    if (duanziList.isEmpty) {
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
      //TODO: content build
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
    DuanZi duanzi = DuanZi.fromJson(response.data);
    _page++;
    if (isClean) {
      duanziList.clear();
    } else {}
    var comments = duanzi.comments;
    for (var comment in comments) {
      duanziList.add(comment.text_content) ;
    }
    setState(() {});
  }
}