import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../functions/date_formatter.dart';
import '../../../utils/constants/questions_constants.dart';
import '../../../utils/enums/questionary_roles.dart';

class SeeResponseQuestionaryPage extends StatefulWidget {
  final TypeQuestionary type;
  final dynamic infoQuestionary;
  const SeeResponseQuestionaryPage({
    super.key,
    required this.type,
    required this.infoQuestionary,
  });

  @override
  State<SeeResponseQuestionaryPage> createState() =>
      _SeeResponseQuestionaryPageState();
}

class _SeeResponseQuestionaryPageState
    extends State<SeeResponseQuestionaryPage> {
  late TypeQuestionary type;
  late dynamic infoQuestionary;

  late Map<String, dynamic> questionsMap = {};

  @override
  void initState() {
    super.initState();
    type = widget.type;
    infoQuestionary = widget.infoQuestionary;
    switch (type) {
      case TypeQuestionary.avaliacao_fisica:
        questionsMap = Questionary.getInitialAvalFisica();
        break;
      case TypeQuestionary.historico_atividades:
        questionsMap = Questionary.getInitialHistAtividades();
        break;
      case TypeQuestionary.historico_doencas:
        questionsMap = Questionary.getInitialHistDoencas();
        break;
      case TypeQuestionary.minha_evolucao:
        questionsMap = Questionary.getInitialEvolucao();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    print(infoQuestionary);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(type.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: type == TypeQuestionary.avaliacao_fisica
            ? buildListFormAvaliacaoFisica()
            : type == TypeQuestionary.historico_atividades
                ? buildListFormHistoricoAtividades()
                : type == TypeQuestionary.historico_doencas
                    ? buildListFormHistoricoDoencas()
                    : buildListFormMinhaEvolucao(),
      ),
    );
  }

  Widget buildListFormAvaliacaoFisica() {
    return ListView(
      children: <Widget>[
        _buildTextFormField('Objetivo', infoQuestionary.objetivos),
        _buildTextFormField('Peso', infoQuestionary.peso),
        _buildTextFormField('Altura', infoQuestionary.altura),
        _buildTextFormField(
            'Data de nascimento',
            DateFormatter()
                .convertToDateTime(infoQuestionary.nascimento.toString())),
      ],
    );
  }

  Widget buildListFormHistoricoAtividades() {
    print(infoQuestionary);
    return ListView(
      children: <Widget>[
        _buildTextFormField(
            'Já pratica algum tipo de atividade física? Se sim a quanto tempo?',
            infoQuestionary.atividadeFisica),
        _buildTextFormField('Faz dieta específica? Se sim com qual objetivo?',
            infoQuestionary.dieta),
        _buildTextFormField('Faz uso de suplementos? Se sim, quais?',
            infoQuestionary.suplementos),
        _buildTextFormField(
            'Fuma? Se sim, quantos cigarros por dia?', infoQuestionary.fuma),
        _buildTextFormField(
            'Consome bebida alcoólica? Se sim, com que frequência?',
            infoQuestionary.bebidaAlcoolica),
        _buildTextFormField('Toma algum medicamento controlado? Quais?',
            infoQuestionary.medicamentoControlado),
        _buildTextFormField(
            'Fez alguma cirurgia? Qual?', infoQuestionary.cirurgia),
      ],
    );
  }

  Widget buildListFormHistoricoDoencas() {
    return ListView(
      children: <Widget>[
        _buildTextFormField(
            'Tem alguma das doenças abaixo?', infoQuestionary.doencas),
        _buildTextFormField(
            'Dores na coluna, articulação ou muscular? Se sim quais?',
            infoQuestionary.dores),
        _buildTextFormField(
            'Alguma queixa adicional? (incômodos, dores, dificuldades)',
            infoQuestionary.adicional),
      ],
    );
  }

  Widget buildListFormMinhaEvolucao() {
    var media = MediaQuery.of(context).size;
    double imageWidth = media.width * 0.45;
    double imageHeight = media.height * 0.3;
    return SingleChildScrollView(
      child: Wrap(
        spacing: 2.0,
        runSpacing: 2.0,
        children: [
          if (infoQuestionary.foto1 != null)
            Image.memory(
              base64Decode(infoQuestionary.foto1),
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            ),
          const SizedBox(height: 15),
          if (infoQuestionary.foto2 != null)
            Image.memory(
              base64Decode(infoQuestionary.foto2),
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            ),
          const SizedBox(height: 15),
          if (infoQuestionary.foto3 != null)
            Image.memory(
              base64Decode(infoQuestionary.foto3),
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            )
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            readOnly: true,
            initialValue: initialValue,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
