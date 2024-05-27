import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mixin/home_state_mixin.dart';
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

class _HomePageAlunoState extends State<HomePageAluno> with HomeStateHelpers<HomePageAluno>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),) : buildHomePageAluno(),
    );
  }

  Widget buildHomePageAluno() {
    return Scaffold(
      appBar: CustomAppBar(
        userName: Provider.of<DataAppProvider>(context, listen: true).userInfos.mensagem.name,
        userImage: Image.memory(base64Decode(Provider.of<DataAppProvider>(context, listen: true).userInfos.photo)),
        type: NavBarType.aluno,
        editRoute: '/edit-aluno-perfil',
      ),
      body: CustomBodyHome(bottomBarPages: bottomBarPagesAluno, type: NavBarType.aluno)
    );
  }
}
