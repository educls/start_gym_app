import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:start_gym_app/models/users/ModelUserInfos.dart';

import '../controllers/users/users_controller.dart';
import '../functions/sign_up/image_helper.dart';
import '../helpers/is_base64_helper.dart';
import '../models/users/ModelEditUser.dart';
import '../utils/constants/path_contants.dart';
import '../utils/provider/data_provider.dart';
import '../widgets/custom_alert.dart';

mixin ImagePickerStateHelper<T extends StatefulWidget> on State<T> {
  
  // late ModelUserInfos userInfos = Provider.of<DataAppProvider>(context, listen: false).userInfos;
  // late Image image = userInfos.foto != null && IsBase64(base64: userInfos.foto!).verify()
  //             ? Image.memory(base64Decode(userInfos.foto!))
  //             : Image.asset(PathConstants.photoDefault);
  List<String?> base64Images = List.filled(3, null);

  void setBase64Image(String base64Img) {
    // DataAppProvider provider = Provider.of<DataAppProvider>(context, listen: false);
    // setState(() {
    //   image = Image.memory(base64Decode(base64Img));
    //   print('image editing');
    //   editUserEachInput(modelEditUserToJson(ModelEditUser(foto: base64Img)), provider.token);
    //   provider.setPhoto(base64Img);
    // });
  }

  void setBase64ImageList(int index, String base64Image) {
    setState(() {
      base64Images[index] = base64Image;
    });
  }

  showPickerDialog(Function(String) callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: "Escolha uma opção",
          action1Title: Icon(
            Icons.photo_library,
            size: 60,
            color: Colors.grey[600],
          ),
          action1: () {
            ImageHelper(
              context: context,
              setImgFile: (file) {},
              setBase64Image: (base64) => callback(base64),
            ).pickImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
          action2Title: Icon(
            Icons.camera_alt,
            size: 60,
            color: Colors.grey[600],
          ),
          action2: () {
            ImageHelper(
              context: context,
              setImgFile: (file) {},
              setBase64Image: (base64) => callback(base64),
            ).pickImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}