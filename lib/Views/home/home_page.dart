import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:start_gym_app/common_widget/navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/users/users_controller.dart';
import '../../models/users/ModelUserInfos.dart';
import '../../utils/provider/data_provider.dart';
import 'admin/agenda_treinos_admin_page.dart';
import 'admin/alunos_admin_page.dart';
import 'admin/professores_admin_page.dart';
import 'admin/treinos_admin_page.dart';
import 'aluno/perfil_aluno.dart';
import 'aluno/treinos_aluno.dart';
import 'professor/agenda_treinos_page.dart';
import 'professor/perfil_professor_page.dart';
import 'professor/treinos_professor_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

enum NavBarType { admin, professor, aluno }

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
    PerfilProfessorPage(),
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
  void setUser(String accountType) {
    setState(() {
      _accountType = accountType;
    });
  }

  void setCurrentIndexNavBar(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  void getInfoUser() async {
    initProvider();
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1000));
    response = await getInformationsUser(value!.token);

    modelUserInfos = modelUserInfosFromMap(response.body);

    bytes = base64Decode(modelUserInfos.photo);
    image = Image.memory(bytes);

    setUser(modelUserInfos.mensagem.accounttype);
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading ||
        value == null ||
        modelUserInfos.mensagem.accounttype == '') {
      getInfoUser();
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: Colors.black,
            size: 30,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Olá ${modelUserInfos.mensagem.name}",
            textAlign: TextAlign.end,
          ),
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 1),
              child: CircleAvatar(
                backgroundImage: image.image,
                radius: 35,
              ),
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.white,
                  size: 30,
                ),
              )
            : Center(
                child: modelUserInfos.mensagem.accounttype == 'admin'
                    ? bottomBarPagesAdmin[_currentIndex]
                    : modelUserInfos.mensagem.accounttype == 'professor'
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
}
