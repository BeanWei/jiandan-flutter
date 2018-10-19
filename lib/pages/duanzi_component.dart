import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiandan/common/label_icon.dart';


Widget renderDuanziRow(Map duanzi) {

  var maintxtRow = new Row(
    children: <Widget>[
      new Expanded(
        child: new Text(
          duanzi['text_content'], style: TextStyle(fontSize: 15.0),
        ),
      )
    ],
  );

  var infoRow = new Row(
    children: <Widget>[
      new FittedBox(
        fit: BoxFit.contain,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            LabelIcon(
              label: duanzi['vote_positive'],
              icon: FontAwesomeIcons.thumbsUp,
              iconColor: Colors.grey,
            ),
            LabelIcon(
              label: duanzi['vote_negative'],
              icon: FontAwesomeIcons.thumbsDown,
              iconColor: Colors.grey,
            ),
            LabelIcon(
              label: duanzi['comment_count'],
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
              maintxtRow,
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: infoRow,
              )
            ],
          ),
        ),
      ),
    ],
  );
}