import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:start_gym_app/mixin/edit_user_state_mixin.dart';
import 'package:start_gym_app/widgets/questionary/custom_questionary_picker.dart';

import '../../../utils/constants/path_contants.dart';
import '../../../utils/enums/edit_user_types.dart';
import '../../../widgets/appbar/custom_appbar_edit_user.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/inputs/custom_editable_field.dart';
import '../../../widgets/inputs/custom_editable_field_name.dart';
import '../../../widgets/custom_img_picker.dart';
import '../../../widgets/custom_loading.dart';

class EditAlunoInfosPage extends StatefulWidget {
  const EditAlunoInfosPage({super.key});

  @override
  State<EditAlunoInfosPage> createState() => _EditAlunoInfosPageState();
}

class _EditAlunoInfosPageState extends State<EditAlunoInfosPage> with EditUserStateHelpers<EditAlunoInfosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),) : buildFormEditUser(),
        ],
      ),
    );
  }

  Widget buildFormEditUser() {
    return SingleChildScrollView(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 400),
          childAnimationBuilder: (widget) => SlideAnimation(
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            const CustomAppBarEditUser(
              title: "Start Gym",
              pathLogo: PathConstants.logoStartGym,
            ),
            const CustomBackButton(),
            CustomEditableFieldName(
              type: TypeEditUser.nome,
            ),
            const CustomImgPickerAvatar(),
            const CustomEditableField(
              label: 'Telefone',
              isPassword: false,
              type: TypeEditUser.telefone,
            ),
            const CustomEditableField(
              label: 'Email',
              isPassword: false,
              type: TypeEditUser.email,
            ),
            const CustomEditableField(
              label: 'Senha',
              isPassword: true,
              type: TypeEditUser.password,
            ),
            const SizedBox(height: 5),
            const QuestionaryPicker(),
          ],
        ),
      ),
    );
  }
}
