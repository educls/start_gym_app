import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';

import '../../common/color_extension.dart';
import '../../mixin/edit_user_state_mixin.dart';
import '../../utils/enums/edit_user_types.dart';

class CustomEditableField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TypeEditUser type;
  const CustomEditableField({
    super.key,
    required this.label,
    required this.isPassword,
    required this.type,
  });

  @override
  State<StatefulWidget> createState() => _CustomEditableFieldState();
}

class _CustomEditableFieldState extends State<CustomEditableField>
    with EditUserStateHelpers<CustomEditableField> {
  void setEditingState(bool setEditing) {
    setState(() {
      isEditing = setEditing;
    });
    if (!isEditing) {
      editUserInfo(controller.text, widget.type);
    }
  }

  @override
  build(BuildContext context) {
    setUser(widget.type);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            color: ColorConstants.darkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 226, 226),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    inputFormatters: widget.type == TypeEditUser.telefone
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ]
                        : [],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEditing ? Colors.black : Colors.black38),
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(isEditing ? Icons.check : Icons.edit,
                            color: Colors.grey),
                        onPressed: () {
                          setEditingState(!isEditing);
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    obscureText:
                        widget.isPassword ? !isEditing : widget.isPassword,
                    readOnly: !isEditing,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
