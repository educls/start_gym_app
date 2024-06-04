import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_gym_app/controllers/users/users_controller.dart';

import '../../common/color_extension.dart';
import '../../models/users/ModelEditUser.dart';
import '../../models/users/ModelUserInfos.dart';
import '../../utils/enums/edit_user_types.dart';
import '../../utils/provider/data_provider.dart';

class CustomEditableFieldName extends StatefulWidget {
  final TypeEditUser type;
  CustomEditableFieldName({
    super.key,
    required this.type,
  });

  @override
  State<CustomEditableFieldName> createState() => _CustomEditableFieldNameState();
}

class _CustomEditableFieldNameState extends State<CustomEditableFieldName> {
  TextEditingController controller = TextEditingController();

  bool isEditing = false;
  void setEditingState(bool _isEditing) {
    DataAppProvider provider = Provider.of<DataAppProvider>(context, listen: false);
    setState(() {
      isEditing = _isEditing;
      if (!isEditing) {
        editUserEachInput(modelEditUserToJson(ModelEditUser(name: controller.text)), Provider.of<DataAppProvider>(context, listen: false).token);
        provider.setName(controller.text);
      }
    });
  }

  void setUser(TypeEditUser type) {
    ModelUserInfos modelUserInfos = Provider.of<DataAppProvider>(context, listen: false).userInfos;
    controller.text = modelUserInfos.name;
  }

  @override
  Widget build(BuildContext context) {
    setUser(widget.type);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        style: TextStyle(
          color: TColor.lighBlue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.grey),
            onPressed: () {
              setEditingState(!isEditing);
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
        ),
        readOnly: !isEditing,
      ),
    );
  }
}
