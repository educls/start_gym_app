
import 'package:flutter/material.dart';

import '../utils/constants/bar_pages_constants.dart';

mixin HomeStateHelpers<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  int currentIndex = 0;
  List<Widget> bottomBarPagesAluno = BarPagesConst.getBottomBarPagesAluno();
  List<Widget> bottomBarPagesAdmin = BarPagesConst.getBottomBarPagesAdmin();
  List<Widget> bottomBarPagesProfessor = BarPagesConst.getBottomBarPagesProfessor();

  void setLoading(bool setLoading) {
    setState(() {
      isLoading = setLoading;
    });
  }

  void setCurrentIndexNavBar(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }
}