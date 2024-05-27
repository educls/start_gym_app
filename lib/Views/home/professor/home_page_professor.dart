import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mixin/home_state_mixin.dart';
import '../../../utils/enums/user_roles.dart';
import '../../../utils/provider/data_provider.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/home/custom_body.dart';


class HomePageProfessor extends StatefulWidget {
  const HomePageProfessor({super.key});

  @override
  State<HomePageProfessor> createState() => _HomePageProfessorState();
}

class _HomePageProfessorState extends State<HomePageProfessor> with HomeStateHelpers<HomePageProfessor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),)
          : buildHomePageProfessor(),
    );
  }

  Widget buildHomePageProfessor() {
    return Scaffold(
      appBar: CustomAppBar(
        userName: Provider.of<DataAppProvider>(context, listen: false).userInfos.mensagem.name,
        userImage: Image.memory(base64Decode(Provider.of<DataAppProvider>(context, listen: false).userInfos.photo)),
        type: NavBarType.professor,
        editRoute: '/edit-professor-perfil',
      ),
      body: CustomBodyHome(bottomBarPages: bottomBarPagesProfessor, type: NavBarType.professor)
    );
  }
}
