import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';

import '../../../helpers/is_base64_helper.dart';
import '../../../mixin/home_state_mixin.dart';
import '../../../utils/constants/path_contants.dart';
import '../../../utils/enums/user_roles.dart';
import '../../../utils/provider/data_provider.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/home/custom_body.dart';

class HomePageAluno extends StatefulWidget {
  const HomePageAluno({super.key});

  @override
  State<HomePageAluno> createState() => _HomePageAlunoState();
}

class _HomePageAlunoState extends State<HomePageAluno>
    with HomeStateHelpers<HomePageAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: isLoading
              ? const CustomLoading(
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              : buildHomePageAluno(),
        ),
      ),
    );
  }

  Widget buildHomePageAluno() {
    // var userInfos = Provider.of<DataAppProvider>(context, listen: true).userInfos;
    return Scaffold(
        backgroundColor: ColorConstants.darkBlue,
        appBar: CustomAppBar(
          userImage: Image.asset(PathConstants.profile),
          // userName: Provider.of<DataAppProvider>(context, listen: true).userInfos.nome,
          // userImage: IsBase64(base64: userInfos.foto!).verify()
          //     ? Image.memory(base64Decode(userInfos.foto!))
          //     : Image.asset(PathConstants.photoDefault),
          type: NavBarType.aluno,
          editRoute: '/edit-aluno-perfil',
        ),
        body: CustomBodyHome(
            bottomBarPages: bottomBarPagesAluno, type: NavBarType.aluno));
  }
}
