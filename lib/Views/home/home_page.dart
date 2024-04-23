import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/provider/data_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final value = context.watch<DataAppProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Provider.value(
        value: value,
        child: Center(
          child: Text(
            'TOKEN = ${value.token}',
            key: const Key("tokenState"),
          ),
        ),
      ),
    );
  }
}
