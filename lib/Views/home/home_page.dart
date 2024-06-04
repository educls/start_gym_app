import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:start_gym_app/common_widget/navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/users/users_controller.dart';
import '../../models/users/ModelUserInfos.dart';
import '../../utils/enums/user_roles.dart';
import '../../utils/provider/data_provider.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/custom_loading.dart';
import 'admin/agenda_treinos_admin_page.dart';
import 'admin/alunos_admin_page.dart';
import 'admin/professores_admin_page.dart';
import 'admin/treinos_admin_page.dart';
import 'aluno/edit_perfil_aluno_page.dart';
import 'aluno/treinos_aluno.dart';
import 'professor/agenda_treinos_page.dart';
import 'professor/treinos_professor_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  DataAppProvider? value;
  late http.Response response;
  bool _isLoading = false;
  Map<String, dynamic> userInfos = {};
  int _currentIndex = 0;
  late ModelUserInfos modelUserInfos;
  late Uint8List bytes;
  late Image image;

  List<Widget> bottomBarPagesProfessor = const [
    TreinosProfessorPage(),
    AgendaTreinosProfessorPage(),
    AlunosAdminPage(),
  ];
  List<Widget> bottomBarPagesAluno = const [
    TreinosAlunoPage(),
    PerfilAlunoPage(),
  ];
  List<Widget> bottomBarPagesAdmin = const [
    TreinosAdminPage(),
    AlunosAdminPage(),
    AgendaTreinosAdminPage(),
    ProfessoresAdminPage(),
  ];

  @override
  void initState() {
    super.initState();
    getInfoUser();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void initProvider() {
    value = context.watch<DataAppProvider>();
  }

  String _accountType = '';
  void setUserType(String accountType) {
    setState(() {
      _accountType = accountType;
    });
  }

  void setCurrentIndexNavBar(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  void getInfoUser() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1000));

    response = await getInformationsUser(Provider.of<DataAppProvider>(context, listen: false).token);
    modelUserInfos = modelUserInfosFromMap(response.body);

    if (isBase64(modelUserInfos.photo!) && modelUserInfos.photo != '') {
      bytes = base64Decode(modelUserInfos.photo!);
      image = Image.memory(bytes);
    } else {
      image = Image.asset('assets/img/profile_tab.png');
    }

    setUserType(modelUserInfos.accounttype);
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: Colors.black,
                size: 30,
              ),
            )
          : buildHomePage(),
    );
  }

  Widget buildHomePage() {
    return Scaffold(
      appBar: CustomAppBar(
        userName: modelUserInfos.name,
        userImage: image,
        type: NavBarType.aluno,
        editRoute: '/edit-aluno-perfil',
      ),
      body: _isLoading
          ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),)
          : Center(
              child: modelUserInfos.accounttype == 'admin'
                  ? bottomBarPagesAdmin[_currentIndex]
                  : modelUserInfos.accounttype == 'professor'
                      ? bottomBarPagesProfessor[_currentIndex]
                      : bottomBarPagesAluno[_currentIndex],
            ),
      bottomNavigationBar: NavBarCustom(
        type: _accountType == 'admin'
            ? NavBarType.admin
            : _accountType == 'professor'
                ? NavBarType.professor
                : NavBarType.aluno,
        itemsBar: _accountType == 'admin'
            ? bottomBarPagesAdmin
            : _accountType == 'professor'
                ? bottomBarPagesProfessor
                : bottomBarPagesAluno,
        currentIndex: _currentIndex,
        setCurrentIndexNavBar: setCurrentIndexNavBar,
      ),
    );
  }
}
