import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: StoreConnector<String, String>(
        converter: (store) => store.state,
        builder: (context, token) {
          return Center(
            child: Text(
              token,
              style: const TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
