import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Адрес:',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.tune,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: ruyxat.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                User restNomi = new User(name: '${ruyxat[index]}');
                User restIzox = new User(malumot: '${izox[index]}');

//                User
                Route route = MaterialPageRoute(
                    builder: (context) => Restaurant(
                          restNomi: restNomi,
                          restIzox: restIzox,
                        ));
                Navigator.push(context, route);
              },
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        height: 150,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${ruyxat[index]}',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${izox[index]}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    '0.0(0)',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ]),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,
                                        color: Colors.black54),
                                    Text('60 min',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.airport_shuttle,
                                        color: Colors.black54),
                                    Text('700 000 sum',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    top: 125,
                    child: Container(
                      color: Colors.blueGrey,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Restaurant extends StatefulWidget {
//  final
  final User restNomi;
  final User restIzox;
  final User index;

  Restaurant({this.restNomi, this.restIzox, this.index});

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: CustomSliverDelegate(
            expandedHeight: 200,
            restNom: widget.restNomi,
            restIzoxs: widget.restIzox,
          ),
        ),
       SliverFillRemaining(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text("1-page"),
                  onPressed: () => controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCubic),
                ),
                RaisedButton(
                  child: Text("2-page"),
                  onPressed: () => controller.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear),
                ),
                RaisedButton(
                  child: Text("3-page"),
                  onPressed: () => controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  itemBuilder: (context, index) {
                    return ListView.separated(
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: ListTile(title: Text('Text[$index]')),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(thickness: 2),
                    );
                  }),
            ),
          ]),
        ),
      ]),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final User restNom;
  final User restIzoxs;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.restNom,
    this.restIzoxs,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Text("${this.restNom.name}")),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 48 * percent, horizontal: 25 * percent),
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${this.restNom.name}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${this.restIzoxs.malumot}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '0.0(0)',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ]),
                            Row(
                              children: <Widget>[
                                Icon(Icons.access_time, color: Colors.black54),
                                Text('60 min',
                                    style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.airport_shuttle,
                                    color: Colors.black54),
                                Text('700 000 sum',
                                    style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class User {
  final String name;
  final String malumot;
  final int index;
  User({
    this.name,
    this.malumot,
    this.index,
  });
}

final List<String> ruyxat = <String>[
  'Sushi-Mushi',
  'Shokolad',
  'ШЕФ Burger(Ц-1)',
  'oshxona'
];
final List<String> izox = <String>[
  'Sushi Rolli i napitki',
  'Yeropeyskie bluda Zavtraki',
  'Burgeri Fast Food',
  'Milliy taomlar'
];
final List<String> SushiMushi = <String>[
  'Sushi',
  'Rolli',
  'Napitki',
];
final List<String> Shokolad = <String>[
  'Zavtrak',
  'Salat',
  'Sup',
  'Vtorie blyudi',
  'Riba',
  'Garnir',
];
final List<String> Burger = <String>[
  'Burgeri',
  'Hot-Dog',
  'Salat',
  'Sous',
  'Napitki',
  'Steyk',
];
