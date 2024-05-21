import 'dart:convert';
import 'dart:ffi';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:start_gym_app/Views/questions/pageToSeeResponseQuestion/seeResponseQuestionary.dart';
import 'package:start_gym_app/Views/questions/questionary_page.dart';
import 'package:start_gym_app/controllers/users/users_controller.dart';
import 'package:start_gym_app/functions/date_formatter.dart';
import 'package:start_gym_app/functions/questionary/questionary_helper.dart';
import 'package:start_gym_app/models/users/ModelGetQuestionaryHistAtividades.dart';
import 'package:start_gym_app/models/users/ModelGetQuestionaryHistDoencas.dart';
import 'package:start_gym_app/models/users/ModelGetQuestionaryMinhaEvolucao.dart';

import '../../common_widget/round_button.dart';
import '../../functions/sign_up/pick_img_perfil.dart';
import '../../models/users/ModelGetQuestionaryAvalFisica.dart';
import '../../utils/constants/questions_constants.dart';
import '../../utils/provider/data_provider.dart';
import '../home/edit_info_user_page.dart';

enum TypeQuestionary {
  avaliacao_fisica,
  historico_atividades,
  historico_doencas,
  minha_evolucao
}

class QuestionarioWidget extends StatefulWidget {
  final TypeQuestionary type;
  const QuestionarioWidget({
    super.key,
    required this.type,
  });

  @override
  State<QuestionarioWidget> createState() => _QuestionarioWidgetState();
}

class _QuestionarioWidgetState extends State<QuestionarioWidget> {
  late TypeQuestionary type;
  DataAppProvider? value;

  dynamic questionsResp;

  bool firstTime = true;

  late http.Response response;

  late List<ModelGetQuestionaryAvaliacaoFisica>
      questionaryInfosAvaliacaoFisica = [];
  late List<ModelGetQuestionaryHistoricoAtividades>
      questionaryInfosHistoricoAtividades = [];
  late List<ModelGetQuestionaryHistoricoDoencas>
      questionaryInfosHistoricoDoencas = [];
  late List<ModelGetQuestionaryMinhaEvolucao> questionaryInfosMinhaEvolucao =
      [];

  void initProvider() {
    value = context.watch<DataAppProvider>();
  }

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  bool _isLoading = false;
  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void setQuestionaryInfos(String _respBody) {
    setState(() {
      switch (type) {
        case TypeQuestionary.avaliacao_fisica:
          questionsResp = modelGetQuestionaryInfosFromMap(_respBody);
          break;
        case TypeQuestionary.historico_atividades:
          questionsResp =
              modelGetQuestionaryHistoricoAtividadesFromMap(_respBody);
          break;
        case TypeQuestionary.historico_doencas:
          questionsResp = modelGetQuestionaryHistoricoDoencasFromMap(_respBody);
          break;
        case TypeQuestionary.minha_evolucao:
          questionsResp = modelGetQuestionaryMinhaEvolucaoFromMap(_respBody);
          break;
        default:
          // Handle default case if necessary
          break;
      }
    });
    print(questionsResp);
    if (questionsResp != null) {
      firstTime = false;
    }
  }

  void getQuestionaryInfos() async {
    setLoading(true);
    initProvider();
    response = await getQuestionary(value!.token, type);

    setQuestionaryInfos(response.body);
    await Future.delayed(const Duration(milliseconds: 1000));
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    if (questionsResp == null) {
      getQuestionaryInfos();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(type.name),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.blue[900]),
              label: Text(
                'Voltar',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : questionsResp.isNotEmpty
                        ? buildListViewsQuestionary()
                        : QuestionaryPage(type: type, firstTime: firstTime),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListViewsQuestionary() {
    return Scaffold(
      body: ListView.builder(
        itemCount: questionsResp.length,
        itemBuilder: (context, index) {
          final infoQuestionary = questionsResp[index];
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
                margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
                child: ListTile(
                  title: Text(
                      '${type.name}\n${DateFormatter().convertToDateTime(infoQuestionary.dataInsercao.toString())}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SeeResponseQuestionaryPage(
                            infoQuestionary: infoQuestionary, type: type)));
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestionaryPage(type: type),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
