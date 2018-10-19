import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiandan/common/label_icon.dart';


Widget renderWuliaoRow(Map wuliao) {
  var imgRow = new Center(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
//        for (var img_url in wuliao['pics']) {
//          new Image(image: new CachedNetworkImageProvider(img_url),
//        }
      //todo: 1.展示多图在一个容器 2.Gif图点击加载
        new Image(image: new CachedNetworkImageProvider(wuliao['pics'][0])),
      ],
    ),
  );

  var infoRow = new Row(
    children: <Widget>[
      new FittedBox(
        fit: BoxFit.contain,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            LabelIcon(
              label: wuliao['vote_positive'],
              icon: FontAwesomeIcons.thumbsUp,
              iconColor: Colors.grey,
            ),
            LabelIcon(
              label: wuliao['vote_negative'],
              icon: FontAwesomeIcons.thumbsDown,
              iconColor: Colors.grey,
            ),
            LabelIcon(
              label: wuliao['comment_count'],
              icon: FontAwesomeIcons.comments,
              iconColor: Colors.grey,
            ),
            LabelIcon(
              label: "",
              icon: FontAwesomeIcons.shareAlt,
              iconColor: Colors.grey,
              //todo: add the share
              onPressed: {},
            ),
          ],
        ),
      )
    ],
  );

  return new Row(
    children: <Widget>[
      new Expanded(
        flex: 1,
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              imgRow,
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: infoRow,
              )
            ],
          ),
        ),
      )
    ],
  );
}
