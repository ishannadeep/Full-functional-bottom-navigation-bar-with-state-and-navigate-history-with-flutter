import 'package:ewallet_test/navprovider.dart';
import 'package:ewallet_test/transaction_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_widget.dart';
import 'home_widget.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<NavigatorState> _key = GlobalKey();
  DateTime _lastQuitTime;
  int _selectedIndex = 0;
  PageController _pageController;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home_widget(),
    Transaction_widget(),
    Account_widget()
  ];

  @override
  void initState() {
    _pageController = new PageController(
      initialPage: _selectedIndex,
    );
    super.initState();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<Navprovider>(
      builder: (context, nav, child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
              onWillPop: () async {
                if (_key.currentState.canPop()) {
                  print("can pop");
                  nav.setPage(_pageController);
                  print("setpage :${nav.currentIndex}");

                  return false;
                } else {
                  print("listpages.isEmpty: ${nav.listpages}");
                  if (nav.listpages.length == 1 && nav.listpages[0] == 0) {
                    if (_lastQuitTime == null ||
                        DateTime.now().difference(_lastQuitTime).inSeconds >
                            4) {
                      print('Press again Back Button exit');
                      _lastQuitTime = DateTime.now();
                      return false;
                    } else {
                      print('sign out');
                      Navigator.of(context).pop(true);
                      return true;
                    }
                  } else {
                    print("setpage");
                    nav.setPage(_pageController);
                    return false;
                  }
                }
              },
              child: Navigator(
                key: _key,
                onGenerateRoute: (RouteSettings settings) =>
                    MaterialPageRoute(builder: (context) {
                  return PageView(
                      controller: _pageController,
                      onPageChanged: (index) =>
                          nav.currentindex_set(index, pageindex: index),
                      //onPageChanged: (index)=>nav.gegegege(),
                      children: [
                        Center(
                          child: Home_widget(),
                        ),
                        Center(
                          child: Transaction_widget(),
                        ),
                        Center(
                          child: Account_widget(),
                        ),
                      ]);
                }),
              ),
            ),
            bottomNavigationBar: bottom_navigation_bar(
                selectedindex: nav.currentIndex,
                ontapped: (index) {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  //print("nav current index: ${nav.currentIndex}");
                  nav.currentindex_set(index, navindex: index);
                  //nav.gegegege();
                }));
      },
    );
  }
}
//.......................................................................................................................................................

class bottom_navigation_bar extends StatefulWidget {
  int selectedindex;
  Function ontapped;

  bottom_navigation_bar({Key key, this.ontapped, this.selectedindex})
      : super(key: key);

  @override
  _bottom_navigation_barState createState() => _bottom_navigation_barState();
}

class _bottom_navigation_barState extends State<bottom_navigation_bar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_rounded),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_rounded),
          label: 'Account',
        ),
      ],
      currentIndex: widget.selectedindex,
      selectedItemColor: Colors.lightBlue,
      onTap: widget.ontapped,
    );
  }
}
