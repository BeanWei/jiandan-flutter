import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jiandan/pages/itemList_page.dart';
import 'package:jiandan/common/config.dart';

class MainPage extends StatefulWidget {
  MainPage(this.configuration, this.updater);

  final JianDanTheme configuration;
  final ValueChanged<JianDanTheme> updater;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  TabController tabController;
  int lastTime = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0 ,length: 4, vsync: this);
  }

  Future<Null> _handleThemeChange(ThemeType value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.updater != null) {
      prefs.setInt('them', value.index);
      widget.updater(widget.configuration.copyWith(themeType: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        key: _globalKey,
        appBar: new AppBar(
          title: new Text('煎蛋'),
          leading: IconButton(
            onPressed: () {
              setState(() {
                _globalKey.currentState.openDrawer();
              });
            },
            icon: Icon(Icons.menu),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, Se),
              },
              icon: Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '新鲜事'),
              Tab(text: '段子手'),
              Tab(text: '妹子图'),
              Tab(text: '无聊图'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            ItemListPage(
              item: 'news',
            ),
            ItemListPage(
              item: 'duanzi',
            ),
            ItemListPage(
              item: 'meizi',
            ),
            ItemListPage(
              item: 'wuliao',
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              FlutterLogo(
                size: 150.0,
                colors: Theme.of(context).primaryColor,
                style: FlutterLogoStyle.horizontal,
              ),
              Divider(),
              ListTile(
                title: Text('Light'),
                trailing: Radio(
                  value: ThemeType.light,
                  groupValue: widget.configuration.themeType,
                  onChanged: _handleThemeChange,
                ),
                onTap: () {
                  _handleThemeChange(ThemeType.light);
                },
              ),
              ListTile(
                title: Text('Dark'),
                trailing: Radio(
                  value: ThemeType.dark,
                  groupValue: widget.configuration.themeType,
                  onChanged: _handleThemeChange,
                ),
                onTap: () {
                  _handleThemeChange(ThemeType.dark);
                },
              ),
              ListTile(
                title: Text('Brown'),
                trailing: Radio(
                  value: ThemeType.brown,
                  groupValue: widget.configuration.themeType,
                  onChanged: _handleThemeChange,
                ),
                onTap: () {
                  _handleThemeChange(ThemeType.brown);
                },
              ),
              ListTile(
                title: Text('Blue'),
                trailing: Radio(
                  value: ThemeType.blue,
                  groupValue: widget.configuration.themeType,
                  onChanged: _handleThemeChange,
                ),
                onTap: () {
                  _handleThemeChange(ThemeType.blue);
                },
              ),
            ]
          ),
        ),
      ),
      onWillPop: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          int newTime = DateTime.now().millisecondsSinceEpoch;
          int result = newTime - lastTime;
          lastTime = newTime;
          if (result > 2000) {
            _globalKey.currentState
                .showSnackBar(SnackBar(content: Text('再按一次退出！')));
          } else {

          }
        }
        return null;
      },
    );
  }
}