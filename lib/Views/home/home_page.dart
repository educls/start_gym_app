import 'dart:convert';
import 'dart:io';
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
import 'aluno/edit_perfil_aluno_page.dart';
import 'aluno/treinos_aluno.dart';
import 'professor/agenda_treinos_page.dart';
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

  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  void getInfoUser() async {
    initProvider();
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1000));
    print(value!.token);
    response = await getInformationsUser(value!.token);

    modelUserInfos = modelUserInfosFromMap(response.body);

    if (isBase64(modelUserInfos.photo) && modelUserInfos.photo != '') {
      bytes = base64Decode(modelUserInfos.photo);
      image = Image.memory(bytes);
    } else {
      image = Image.asset('assets/img/profile_tab.png');
    }

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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit-user-perfil');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 1),
                child: CircleAvatar(
                  backgroundImage: image.image,
                  radius: 35,
                ),
              ),
            )
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

  Future<Uint8List> imageToBytes(String imagePath) async {
    // Carrega a imagem como um arquivo
    File imageFile = File(imagePath);

    // Verifica se o arquivo de imagem existe
    // Lê o conteúdo do arquivo como bytes
    List<int> bytes = await imageFile.readAsBytes();

    // Converte a lista de inteiros em Uint8List
    Uint8List uint8list = Uint8List.fromList(bytes);

    // Retorna os bytes da imagem
    return uint8list;
  }
}
