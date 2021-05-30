import 'package:flutter/material.dart';

class Account_widget extends StatefulWidget {
  const Account_widget({Key key}) : super(key: key);

  @override
  _Account_widgetState createState() => _Account_widgetState();
}

class _Account_widgetState extends State<Account_widget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: Text("Account"),
    ));
  }
}
