import 'package:flutter/cupertino.dart';

class Navprovider extends ChangeNotifier {
  String _name = "hello";
  int _currentScreenIndex = 0;
  int lastIndex;
  List<int> _pages = List.from([0]);

  //List<int> _pages =[];
  List<int> get listpages => _pages;

  int get currentIndex => _currentScreenIndex;

  void currentindex_set(int index, {int navindex, int pageindex}) {
    print("nav index : $navindex and page index : $pageindex ");
    print("Page list : $_pages");
    print("lastIndex : $lastIndex ");

    if (_pages.length == 4) {
      _pages.removeAt(1);
    }
    if (_pages.last != null) {
      lastIndex = _pages.last;
//print("page index : $pageindex");
      if (navindex == null) {
        if (_pages.length >= 2 &&
            (_pages.last == 2 && _pages[_pages.length - 2] == 0 ||
                _pages.last == 0 && _pages[_pages.length - 2] == 2)) {
        } else {
          print("if(navindex==null) ");
          if (index != _pages.last) {
            if (index == 0) {
              _pages.clear();
            }
            _currentScreenIndex = index;
            //lastIndex=_pages.last;
            _pages.add(index);
            notifyListeners();
          }
        }
      } else if (navindex == 2 && lastIndex == 0 && pageindex == null) {
        print("if(navindex==2 && lastIndex==0 && pageindex==null) ");
        if (navindex != _pages.last) {
          _currentScreenIndex = navindex;
          //lastIndex=0;
          _pages.add(navindex);
          notifyListeners();
        }
      } else if (navindex == 0 && lastIndex == 2 && pageindex == null) {
        print("if(navindex==0 && lastIndex==2 && pageindex==null) ");
        if (navindex != _pages.last) {
          _pages.clear();

          _currentScreenIndex = navindex;
          // lastIndex=2;
          _pages.add(navindex);
          notifyListeners();
        }
      } else if (navindex == 1 &&
          pageindex == null &&
          (lastIndex == 2 || lastIndex == 0)) {
        print(
            "navindex==1 && lastIndex==2 && pageindex==null || navindex==1 && lastIndex==0 && pageindex==null");
        if (navindex != _pages.last) {
          _currentScreenIndex = navindex;
          // lastIndex=2;
          _pages.add(navindex);
          notifyListeners();
        }
      }
    }

    print(
        "------------------------------------------------------------------------ ");
  }

  void setPage(PageController _pageController) {
    print("inside setpage");
    if (lastIndex != null) {
      _currentScreenIndex = _pages[_pages.length - 2];
      if (_pages.isNotEmpty) {
        _pages.removeLast();
        print("page removed");
        notifyListeners();
        _pageController.animateToPage(_currentScreenIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    }
  }

  void addstring(String name) {
    _name = name;
    notifyListeners();
  }

  String get name => _name;
}
