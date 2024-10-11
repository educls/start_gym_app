import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';
import 'package:start_gym_app/views/home/professor/exercicios/treino_por_categoria_screen.dart';

import '../../../controllers/users/users_controller.dart';
import '../../../models/users/ModelALunosInfos.dart';
import '../../../utils/provider/data_provider.dart';

class AlunosAdminPage extends StatefulWidget {
  const AlunosAdminPage({super.key});

  @override
  State<AlunosAdminPage> createState() => _AlunosAdminPageState();
}

class _AlunosAdminPageState extends State<AlunosAdminPage> {
  late String userToken;
  List<ModelAlunosInfos> alunosInfos = [];
  late http.Response response;
  // DataAppProvider? value;
  late Uint8List bytes;
  late Image image = Image.asset(PathConstants.profile);

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  // void initProvider() {
  //   value = context.watch<DataAppProvider>();
  // }

  // void setAlunosInfos(resAlunosInfos) {
  //   setState(() {
  //     alunosInfos = resAlunosInfos;
  //   });
  // }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  // Future<void> searchAlunosInfos() async {
  //   initProvider();
  //   response = await getAlunosInfos(value!.token);
  //   List<ModelAlunosInfos> _alunosInfos =
  //       modelAlunosInfosFromMap(response.body);
  //   setAlunosInfos(_alunosInfos);
  // }

  // Future<void> reloadAlunosInfos() async {
  //   setLoading(true);
  //   searchAlunosInfos();
  //   Timer(
  //     const Duration(milliseconds: 500),
  //     () {
  //       setLoading(false);
  //     },
  //   );
  // }

  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (alunosInfos.isEmpty) {
    //   reloadAlunosInfos();
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alunos"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                // final infoAluno = alunosInfos[index];
                Uint8List photoBytes = Uint8List(0);
                // if (infoAluno.foto != null && isBase64(infoAluno.foto!)) {
                //   photoBytes = base64Decode(infoAluno.foto!);
                // }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 0.705),
                      elevation: 8,
                      margin:
                          const EdgeInsets.only(top: 30, right: 10, left: 10),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: CircleAvatar(
                            backgroundImage: image.image,
                            radius: 25,
                          ),
                        ),
                        title: Text('infoAluno.email!'),
                        trailing: Text('(xx) xxxxx-xxxx'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  AlertDialog(
                                    title: Column(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: CircleAvatar(
                                              backgroundImage: image.image,
                                              radius: 80,
                                            ),
                                          ),
                                        ),
                                        Center(child: Text('infoAluno.email!'))
                                      ],
                                    ),
                                    content: Text(
                                        'Nome: ${'infoAluno.nome'} \nNumero: ${'infoAluno.telefone'}\n'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TreinoPorCategoriaScreen()));
                                        },
                                        child: const Text('Atribuir Treino'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Voltar'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/sign-up-new-aluno');
        },
        child: Image.asset('assets/images/home_professor/alunoAdd.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
