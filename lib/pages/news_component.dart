import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jiandan/pages/news_detail_page.dart';

Widget renderNewsRow(Map news, BuildContext context) {

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

  var titleRow = new Row(
    children: <Widget>[
      new Expanded(
          child: new Text(news['title'], style: titleTextStyle))
    ],
  );

  var infoRow = new Row(
    children: <Widget>[
      new Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Icon(Icons.access_time),
            new Text(news['date'], style: subtitleTextStyle,),
          ],
        ),
      ),
      new Expanded(
        flex: 1,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Icon(Icons.comment),
            new Text(news['comment_count'].toString(), style: subtitleTextStyle,),
          ],
        ),
      )
    ],
  );

  var coverImg = new Container(
    margin: const EdgeInsets.all(10.0),
    width: 60.0,
    height: 60.0,
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xFFECECEC),
      image: new DecorationImage(image: new CachedNetworkImageProvider(news['cover']), fit: BoxFit.cover),
      border: new Border.all(color: const Color(0xFFECECEC), width: 2.0),
    ),
  );

  var row = new Row(
    children: <Widget>[
      new Expanded(
        flex: 1,
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              titleRow,
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: infoRow,
              )
            ],
          ),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(6.0),
        child: new Container(
          width: 100.0,
          height: 80.0,
          color: const Color(0xFFECECEC),
          child: new Center(
            child: coverImg,
          ),
        ),
      )
    ],
  );

  return new InkWell(
    child: row,
    onTap: () {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (ctx) => NewsDetailPage(url: news['url'],)
      ));
    },
  );
}

