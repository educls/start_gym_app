import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/is_base64_helper.dart';
import '../../../mixin/home_state_mixin.dart';
import '../../../utils/constants/path_contants.dart';
import '../../../utils/enums/user_roles.dart';
import '../../../utils/provider/data_provider.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/home/custom_body.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> with HomeStateHelpers<HomePageAdmin> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),)
          : buildHomePageAdmin(),
    );
  }

  Widget buildHomePageAdmin() {
    var userInfos = Provider.of<DataAppProvider>(context, listen: true).userInfos;
    return Scaffold(
      appBar: CustomAppBar(
        userName: Provider.of<DataAppProvider>(context, listen: false).userInfos.name,
        userImage: userInfos.photo != null && IsBase64(base64: userInfos.photo!).verify()
              ? Image.memory(base64Decode(userInfos.photo!))
              : Image.asset(PathConstants.photoDefault),
        type: NavBarType.admin,
        editRoute: '/edit-admin-perfil',
      ),
      body: CustomBodyHome(bottomBarPages: bottomBarPagesAdmin, type: NavBarType.admin)
    );
  }
}