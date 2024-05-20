import 'package:collection/collection.dart';

class Choice {
  final String title;
  bool isSelected;

  Choice({required this.title, this.isSelected = false});
}

class Questionary {
  static Map<String, dynamic> getInitialAvalFisica() {
    return {
      'Objetivo': [
        Choice(title: 'Ganho de massa magra', isSelected: false),
        Choice(title: 'Perda de gordura corporal', isSelected: false),
        Choice(title: 'Bem-estar e qualidade de vida', isSelected: false),
        Choice(title: 'Tratamento de lesão', isSelected: false),
      ],
      'Peso': 000.0,
      'Altura': 0.00,
      'Data de nascimento': DateTime.now()
    };
  }

  static Map<String, dynamic> getInitialHistAtividades() {
    return {
      'Já pratica algum tipo de atividade física? Se sim a quanto tempo?': '',
      'Faz dieta específica? Se sim com qual objetivo?': '',
      'Faz uso de suplementos? Se sim, quais?': '',
      'Fuma? Se sim, quantos cigarros por dia?': '',
      'Consome bebida alcoólica? Se sim, com que frequência?': '',
      'Toma algum medicamento controlado? Quais?': '',
      'Fez alguma cirurgia? Qual?': ''
    };
  }

  static Map<String, dynamic> getInitialHistDoencas() {
    return {
      'Tem alguma das doenças abaixo?': UnmodifiableListView([
        Choice(title: 'Diabetes', isSelected: false),
        Choice(title: 'Colesterol', isSelected: false),
        Choice(title: 'Trigliceris', isSelected: false),
        Choice(title: 'Hipertensão', isSelected: false),
        Choice(title: 'Diabetes', isSelected: false),
        Choice(title: 'Problemas pulmonares', isSelected: false),
      ]),
      'Dores na coluna, articulação ou muscular? Se sim quais?': '',
      'Alguma queixa adicional? (incômodos, dores, dificuldades)': ''
    };
  }

  static Map<String, dynamic> getInitialEvolucao() {
    return {'Foto 1': '', 'Foto 2': '', 'Foto 3': ''};
  }
}
