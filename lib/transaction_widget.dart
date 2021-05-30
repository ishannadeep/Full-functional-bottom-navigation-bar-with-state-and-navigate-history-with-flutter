import 'package:flutter/material.dart';

class Transaction_widget extends StatefulWidget {
  const Transaction_widget({Key key}) : super(key: key);

  @override
  _Transaction_widgetState createState() => _Transaction_widgetState();
}

class _Transaction_widgetState extends State<Transaction_widget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: Text("Transaction"),
    ));
  }
}
