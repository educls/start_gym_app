// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:start_gym_app/widgets/custom_editable_field_name.dart';
// import 'package:start_gym_app/widgets/custom_img_picker.dart';
// import '../../utils/enums/edit_user_types.dart';
// import '../../utils/enums/questionary_roles.dart';
// import '../../widgets/custom_back_button.dart';
// import '../../widgets/custom_editable_field.dart';
// import '../../widgets/custom_loading.dart';
// import '../../widgets/custom_options_questionary.dart';

// class EditInfoUserPage extends StatefulWidget {
//   const EditInfoUserPage({super.key});

//   @override
//   State<EditInfoUserPage> createState() => _EditInfoUserPageState();
// }

// class _EditInfoUserPageState extends State<EditInfoUserPage> {
//   bool _isLoading = false;
//   void setLoading(bool isLoading) {
//     setState(() {
//       _isLoading = isLoading;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _isLoading ? const CustomLoading() : buildFormEditUser(),
//         ],
//       ),
//     );
//   }

//   Widget buildFormEditUser() {
//     var media = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: AnimationConfiguration.toStaggeredList(
//             duration: const Duration(milliseconds: 350),
//             childAnimationBuilder: (widget) => SlideAnimation(
//               child: FadeInAnimation(
//                 child: widget,
//               ),
//             ),
//             children: [
//               SizedBox(height: media.height * 0.03),
//               const CustomBackButton(),
//               CustomEditableFieldName(
//                 type: TypeEditUser.name,
//               ),
//               const SizedBox(height: 5),
//               const CustomImgPickerAvatar(),
//               const SizedBox(height: 10),
//               const CustomEditableField(
//                 label: 'Telefone',
//                 isPassword: false,
//                 type: TypeEditUser.numWhats,
//               ),
//               const CustomEditableField(
//                 label: 'Email',
//                 isPassword: false,
//                 type: TypeEditUser.email,
//               ),
//               const CustomEditableField(
//                 label: 'Senha',
//                 isPassword: true,
//                 type: TypeEditUser.password,
//               ),
//               const SizedBox(height: 5),
//               const OptionsQuestionary(text: 'Avaliação física', type: TypeQuestionary.avaliacao_fisica),
//               const OptionsQuestionary(text: 'Histórico de atividades', type: TypeQuestionary.historico_atividades),
//               const OptionsQuestionary(text: 'Histórico de doenças', type: TypeQuestionary.historico_doencas),
//               const OptionsQuestionary(text: 'Minha evolução', type: TypeQuestionary.minha_evolucao),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
