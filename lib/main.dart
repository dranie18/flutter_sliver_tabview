import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SilverAppBarWithTabBarScreen(),
    );
  }
}

class SilverAppBarWithTabBarScreen extends StatefulWidget {
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState();
}

class _SilverAppBarWithTabBarState extends State<SilverAppBarWithTabBarScreen> with SingleTickerProviderStateMixin {
  TabController controller;

  List<Widget> tabs = [
    TabViewList(title: 'Tab1'),
    TabViewList(title: 'Tab2'),
    TabViewList(title: 'Tab3'),
  ];

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  // bottom: TabBar(
                  //   // These are the widgets to put in each tab in the tab bar.
                  //   tabs: tabs.map((name) => Tab(text: 'Hello')).toList(),
                  // ),
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(),
              pinned: false,
            ),
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              TabBar(
                controller: controller,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Tab 1"),
                  Tab(text: "Tab 1"),
                  Tab(text: "Tab 2"),
                ],
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: controller,
                    children: tabs.map((tab) => tab).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabViewList extends StatefulWidget {
  final String title;
  TabViewList({this.title});

  _TabViewListState createState() => _TabViewListState();
}

class _TabViewListState extends State<TabViewList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: Icon(Icons.access_alarm),
            leading: Icon(Icons.accessibility_new),
            title: Text('${widget.title}'),
            subtitle: Text("hello kappa 123"),
          );
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 110;
  @override
  double get maxExtent => 110;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
