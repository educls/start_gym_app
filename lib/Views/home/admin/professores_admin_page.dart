import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:start_gym_app/models/users/ModelTeachersInfos.dart';

import '../../../controllers/users/users_controller.dart';
import '../../../utils/provider/data_provider.dart';

class ProfessoresAdminPage extends StatefulWidget {
  const ProfessoresAdminPage({super.key});

  @override
  State<ProfessoresAdminPage> createState() => _ProfessoresAdminPageState();
}

class _ProfessoresAdminPageState extends State<ProfessoresAdminPage> {
  late String userToken;
  List<ModelTeachersInfos> professoresInfos = [];
  late http.Response response;
  DataAppProvider? value;
  late Uint8List bytes;
  late Image image = Image.asset('assets/img/profile_tab.png');

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  void initProvider() {
    value = context.watch<DataAppProvider>();
  }

  void setTeacherInfos(resProfessoresInfos) {
    setState(() {
      professoresInfos = resProfessoresInfos;
    });
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> searchTeacherInfos() async {
    initProvider();
    response = await getTeachersInfos(value!.token);
    List<ModelTeachersInfos> _professoresInfos =
        modelTeachersInfosFromMap(response.body);
    setTeacherInfos(_professoresInfos);
  }

  Future<void> reloadTeacherInfos() async {
    setLoading(true);
    searchTeacherInfos();
    Timer(
      const Duration(milliseconds: 500),
      () {
        setLoading(false);
      },
    );
  }

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
    if (professoresInfos.isEmpty) {
      reloadTeacherInfos();
    }
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: professoresInfos.length,
              itemBuilder: (context, index) {
                final infoTeacher = professoresInfos[index];
                Uint8List photoBytes = Uint8List(0);
                if (infoTeacher.photo != null && isBase64(infoTeacher.photo!)) {
                  photoBytes = base64Decode(infoTeacher.photo!);
                }
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
                            backgroundImage: infoTeacher.photo != null &&
                                    isBase64(infoTeacher.photo!)
                                ? MemoryImage(photoBytes)
                                : image.image,
                            radius: 25,
                          ),
                        ),
                        title: Text(infoTeacher.name),
                        trailing: Text(infoTeacher.numberwhats),
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
                                              backgroundImage: infoTeacher
                                                              .photo !=
                                                          null &&
                                                      isBase64(
                                                          infoTeacher.photo!)
                                                  ? MemoryImage(photoBytes)
                                                  : image.image,
                                              radius: 80,
                                            ),
                                          ),
                                        ),
                                        Center(child: Text(infoTeacher.name))
                                      ],
                                    ),
                                    content: Text(
                                        'Nome: ${infoTeacher.name} \nNumero: ${infoTeacher.numberwhats}\n'),
                                    actions: [
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
          Navigator.pushNamed(context, '/sign-up-new-teacher');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
