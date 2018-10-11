import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jiandan/models/meizi.dart';
import 'package:jiandan/pages/meizi/meizi_grid_item.dart';
import 'package:jiandan/utils/http_utils.dart';

class MeiziPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeiziPageState();
}

class MeiziPageState extends State<MeiziPage> {
  List<Meizi> meiziList = [];

  void _openDetails(BuildContext context, Meizi meizi) {
    AlertDialog(title: Text('进入详情'));
  }

  void _fetchMeizi() {
    String url = 'http://jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=1';
    HttpUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var comments = map['comments'];
        setState(() {
         for (var comment in comments) {
           var pics = comment['pics'];
           Meizi meizi = new Meizi(title: '福利', url: pics[0]);
           meiziList.add(meizi);
         }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMeizi();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var crossAxisChildCount = isPortrait ? 2 : 4;

    return Container(
      child: Scrollbar(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisChildCount,
                  childAspectRatio: 2 / 3,
              ),
              itemCount: meiziList.length,
              itemBuilder: (BuildContext context, int index) {
                var meizi = meiziList[index];
                return MeiziGridItem(
                  meizi: meizi,
                  onTapped: () => _openDetails(context, meizi),
                );
              })),
    );
  }

}