import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:start_gym_app/mixin/edit_user_state_mixin.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';
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

class _EditAlunoInfosPageState extends State<EditAlunoInfosPage>
    with EditUserStateHelpers<EditAlunoInfosPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? const CustomLoading(color: ColorConstants.darkBlue)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildFormEditUser(media)),
                      const SizedBox
                          .shrink(), // Para ocupar espaço sem conteúdo
                      const QuestionaryPicker(), // Fica na parte inferior
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildFormEditUser(MediaQueryData media) {
    double containerHeight =
        media.size.height * 0.8; // Ajuste conforme necessário
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
            SizedBox(height: media.size.height * 0.02), // Margem superior
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: media.size.width * 0.05),
              child: CustomEditableFieldName(
                type: TypeEditUser.nome,
              ),
            ),
            const CustomImgPickerAvatar(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: media.size.width * 0.01),
              child: const CustomEditableField(
                label: 'Telefone',
                isPassword: false,
                type: TypeEditUser.telefone,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: media.size.width * 0.01),
              child: const CustomEditableField(
                label: 'Email',
                isPassword: false,
                type: TypeEditUser.email,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: media.size.width * 0.01),
              child: const CustomEditableField(
                label: 'Senha',
                isPassword: true,
                type: TypeEditUser.password,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
