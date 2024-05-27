import 'package:http/http.dart' as http;
import 'package:start_gym_app/models/users/ModelAvaliacaoFisica.dart';
import 'package:start_gym_app/models/users/ModelEditUser.dart';
import 'package:start_gym_app/models/users/ModelEvolucao.dart';
import 'package:start_gym_app/models/users/ModelHistoricoAtividades.dart';
import 'package:start_gym_app/models/users/ModelHistoricoDoencas.dart';
import 'package:start_gym_app/models/users/ModelSignUpNewTeacher.dart';

import '../../models/users/LoginModel.dart';
import '../../models/users/SendEmailForResetModel.dart';
import '../../models/users/SignUpModel.dart';
import '../../services/users/users_service.dart';
import '../../utils/enums/questionary_roles.dart';

FetchApiUsers fetchApiUsers = FetchApiUsers();

Future<http.Response> userLogin(String email, String password) async {
  var dataForLogin = userLoginToJson(UserLogin(email: email, password: password));

  http.Response response = await fetchApiUsers.fetchLoginUsers(dataForLogin);

  return response;
}

Future<http.Response> userSignUp(String accountType, String photo, String name, String numWhats, String email, String password) async {
  var dataForSignUp = signUpModelToJson(SignUpModel(accountType: accountType, photo: photo, name: name, numWhats: numWhats, email: email, password: password));

  http.Response response = await fetchApiUsers.fetchSignUpForUsers(dataForSignUp);

  return response;
}

Future<http.Response> userSendEmailForResetPassword(String email) async {
  var dataBySendEmail = sendEmailForResetToJson(SendEmailForReset(email: email));

  http.Response response = await fetchApiUsers.fetchSendEmailForReset(dataBySendEmail);

  return response;
}

Future<http.Response> checkIfEmailIsVerified(String email) async {
  http.Response response = await fetchApiUsers.fetchForCheckIfEmailWasVerified(email);

  return response;
}

Future<http.Response> deleteEmailIsAboutVerified(String email) async {
  http.Response response = await fetchApiUsers.fetchForDeleteEmailIsAboutVerified(email);

  return response;
}

Future<http.Response> sendEmailForVerifiedEmail(String email) async {
  var sendEmailData = sendEmailForResetToJson(SendEmailForReset(email: email));

  http.Response response = await fetchApiUsers.fetchForSendEmailForVerifyEmail(sendEmailData);

  return response;
}

Future<http.Response> getInformationsUser(String token) async {
  http.Response response = await fetchApiUsers.fetchInfosUser(token);

  return response;
}

Future<http.Response> getTeachersInfos(String token) async {
  http.Response response = await fetchApiUsers.fetchTeachersInfos(token);

  return response;
}

Future<http.Response> getAlunosInfos(String token) async {
  http.Response response = await fetchApiUsers.fetchAlunosInfos(token);

  return response;
}

Future<http.Response> signUpNewTeacher(String name, String email, String password, String teachertype, String userToken) async {
  var data = modelSignUpTeacherToJson(
    ModelSignUpTeacher(name: name, email: email, password: password, teachertype: teachertype),
  );

  http.Response response = await fetchApiUsers.fetchSignUpNewTeacher(data, userToken);

  return response;
}

Future<http.Response> signUpNewAluno(String name, String email, String password, String userToken) async {
  http.Response response = await fetchApiUsers.fetchSignUpNewAluno(name, email, password, userToken);

  return response;
}

Future<http.Response> editUser(String photo, String name, String numWhats, String email, String password, String userToken) async {
  var data = modelEditUserToJson(
    ModelEditUser(photo: photo, name: name, numWhats: numWhats, email: email, password: password),
  );

  http.Response response = await fetchApiUsers.fetchEditUser(data, userToken);

  return response;
}

Future<http.Response> editUserEachInput(String data, String userToken) async {
  http.Response response = await fetchApiUsers.fetchEditUser(data, userToken);

  return response;
}

Future<http.Response> getQuestionary(String token, TypeQuestionary type) async {
  http.Response response = await fetchApiUsers.fetchGetQuestionary(token, type.name);

  return response;
}

sendImageListMinhaEvolucao(String token, List<String?> imagesListBase64, TypeQuestionary type) async {
  dynamic dataForFetch = modelQuestionEvolucaoToJson(
    ModelQuestionEvolucao(
      foto1: imagesListBase64[0],
      foto2: imagesListBase64[1],
      foto3: imagesListBase64[2],
    ),
  );
  fetchApiUsers.fetchListImagesMinhaEvolucao(dataForFetch, token, type.name);
}

sendQuestionaryToApi(String token, Map<String, dynamic> questionsResp, TypeQuestionary type) async {
  late String index;
  late String selectedChoicesString;
  List<String> selectedChoices = [];

  late dynamic dataForFetch;

  setChoicesToString() async {
    if (index.isNotEmpty) {
      for (var item in questionsResp[index]) {
        if (item.isSelected) {
          selectedChoices.add(item.title);
        }
      }
      selectedChoicesString = selectedChoices.join(', ');
    }
  }

  switch (type) {
    case TypeQuestionary.avaliacao_fisica:
      index = 'Objetivo';
      await setChoicesToString();
      dataForFetch = modelQuestionAvaliacaoFisicaToJson(
        ModelQuestionAvaliacaoFisica(
          objetivos: selectedChoicesString,
          peso: questionsResp['Peso'],
          altura: questionsResp['Altura'],
          nascimento: questionsResp['Data de nascimento'],
        ),
      );
      break;
    case TypeQuestionary.historico_doencas:
      index = 'Tem alguma das doenças abaixo?';
      await setChoicesToString();
      dataForFetch = modelQuestionHistoricoDoencasToJson(
        ModelQuestionHistoricoDoencas(
          doencas: selectedChoicesString,
          dores: questionsResp['Dores na coluna, articulação ou muscular? Se sim quais?'],
          adicional: questionsResp['Alguma queixa adicional? (incômodos, dores, dificuldades)'],
        ),
      );
      break;
    case TypeQuestionary.historico_atividades:
      dataForFetch = modelQuestionHistoricoAtividadesToJson(
        ModelQuestionHistoricoAtividades(
          atividadeFisica: questionsResp['Já pratica algum tipo de atividade física? Se sim a quanto tempo?'],
          dieta: questionsResp['Faz dieta específica? Se sim com qual objetivo?'],
          suplementos: questionsResp['Faz uso de suplementos? Se sim, quais?'],
          fuma: questionsResp['Fuma? Se sim, quantos cigarros por dia?'],
          bebidaAlcoolica: questionsResp['Consome bebida alcoólica? Se sim, com que frequência?'],
          medicamentoControlado: questionsResp['Toma algum medicamento controlado? Quais?'],
          cirurgia: questionsResp['Fez alguma cirurgia? Qual?'],
        ),
      );
      break;
    default:
  }
  fetchApiUsers.fetchQuestionary(dataForFetch, token, type.name);
}
