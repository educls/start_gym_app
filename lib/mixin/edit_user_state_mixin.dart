

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/users/users_controller.dart';
import '../models/users/ModelEditUser.dart';
import '../models/users/ModelUserInfos.dart';
import '../utils/enums/edit_user_types.dart';
import '../utils/provider/data_provider.dart';

mixin EditUserStateHelpers<T extends StatefulWidget> on State<T> {
  TextEditingController controller = TextEditingController();
  bool isEditing = false;

  bool isLoading = false;
  void setLoading(bool setLoading) {
    setState(() {
      isLoading = setLoading;
    });
  }

  void editUserInfo(String data, TypeEditUser type) {
    DataAppProvider provider = Provider.of<DataAppProvider>(context, listen: false);
    late String dataForFetch;
    switch (type) {
      case TypeEditUser.numWhats:
        dataForFetch = modelEditUserToJson(ModelEditUser(numWhats: data));
        setState(() {
          provider.setNumWhats(data);
        });
        break;
      case TypeEditUser.email:
        dataForFetch = modelEditUserToJson(ModelEditUser(email: data));
        setState(() {
          provider.setEmail(data);
        });
        break;
      case TypeEditUser.password:
        dataForFetch = modelEditUserToJson(ModelEditUser(password: data));
        setState(() {
          provider.setPassword(data);
        });
        break;
      default:
    }
    editUserEachInput(dataForFetch, provider.token);
  }

  void setUser(TypeEditUser type) {
    ModelUserInfos provider = Provider.of<DataAppProvider>(context, listen: false).userInfos;
    setState(() {
      switch (type) {
        case TypeEditUser.numWhats:
          controller.text = provider.numberwhats ?? '(xx) xxxxx-xxxx';
          break;
        case TypeEditUser.email:
          controller.text = provider.email;
          break;
        case TypeEditUser.password:
          controller.text = provider.password;
          break;
        default:
      }
    });
  }
}