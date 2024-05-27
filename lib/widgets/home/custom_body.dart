import 'package:flutter/material.dart';

import '../../common_widget/navigation_bar.dart';
import '../../mixin/home_state_mixin.dart';
import '../../utils/enums/user_roles.dart';
import '../custom_loading.dart';

class CustomBodyHome extends StatefulWidget {
  final List<Widget> bottomBarPages;
  final NavBarType type;
  const CustomBodyHome({
    super.key,
    required this.bottomBarPages,
    required this.type,
  });

  @override
  State<CustomBodyHome> createState() => _CustomBodyHomeState();
}

class _CustomBodyHomeState extends State<CustomBodyHome> with HomeStateHelpers<CustomBodyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? const CustomLoading(color: Color.fromARGB(255, 0, 0, 0),) : Center(child: widget.bottomBarPages[currentIndex]),
      bottomNavigationBar: NavBarCustom(
        type: widget.type,
        itemsBar: widget.bottomBarPages,
        currentIndex: currentIndex,
        setCurrentIndexNavBar: setCurrentIndexNavBar,
      ),
    );
  }
}
