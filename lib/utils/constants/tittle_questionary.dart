import '../enums/questionary_roles.dart';

class TittleQuestionary {
  static String getTittleQuestionary(TypeQuestionary type) {
    switch (type) {
      case TypeQuestionary.avaliacao_fisica:
        return 'Avaliação Fisica';
      case TypeQuestionary.historico_atividades:
        return 'Histórico de Atividade';
      case TypeQuestionary.historico_doencas:
        return 'Histórico de Doenças';
      case TypeQuestionary.minha_evolucao:
        return 'Minha Evolução';
    }
  }
}
