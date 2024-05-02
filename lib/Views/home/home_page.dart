import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:start_gym_app/Views/home/admin/home_admin_page.dart';
import 'package:start_gym_app/Views/home/aluno/home_aluno_page.dart';
import 'package:start_gym_app/Views/home/professor/home_professor_page.dart';
import 'package:start_gym_app/models/users/GetUserApiModel.dart';

import '../../controllers/users/users_controller.dart';
import '../../utils/provider/data_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataAppProvider? value;
  late http.Response response;
  bool _isLoading = false;
  Map<String, dynamic> userInfos = {};

  @override
  void initState() {
    super.initState();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void initProvider() async {
    value = context.watch<DataAppProvider>();
    print(value!.token);
  }

  String _accountType = '';
  int _id = 0;
  String _name = 'nome';
  String _email = 'email';
  void setUser(String name, String email, int id, String accountType) {
    setState(() {
      _name = name;
      _email = email;
      _id = id;
      _accountType = accountType;
    });
  }

  void getInfoUser() async {
    setLoading(true);
    response = await getInformationsUser(value!.token);
    userInfos = jsonDecode(response.body);
    print(userInfos);
    // body = modelGetUserFromMap(response.body);
    // print(body!.accounttype);
    setUser(userInfos['name'], userInfos['email'], userInfos['id'],
        userInfos['accounttype']);
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    if (value == null || userInfos.isEmpty) {
      initProvider();
      getInfoUser();
      return const Center(child: CircularProgressIndicator());
    } else {
      return Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _accountType == 'aluno'
                  ? const HomePageAluno()
                  : _accountType == 'professor'
                      ? const HomePageProfessor()
                      : const HomePageAdmin()
        ],
      );
    }
  }
}
