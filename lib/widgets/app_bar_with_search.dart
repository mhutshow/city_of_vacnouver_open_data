import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:vancouver_open_data/widgets/text_icon_button.dart';

import '../config/styles.dart';
import 'Responsive.dart';

AppBarWithSearchSwitch appbarWithSearch(
    {required String buttonTitle,
      required void Function(String) onChanged,
      required IconData icon,
      required final VoidCallback onPressed,
      required String title}) {
  return AppBarWithSearchSwitch(
      primary: true,
      elevation: 0,
      backgroundColor: primaryColor.withOpacity(0.8),
      onChanged: onChanged,
       iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white),
      appBarBuilder: (context) {
        return AppBar(
            actionsIconTheme: const IconThemeData(color: Colors.white),
            primary: true,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: primaryColor,
            // leading: Responsive.isMobile(context)
            //     ? IconButton(
            //   icon: const Icon(Icons.na.bars),
            //   onPressed: () {
            //     sidebarScaffoldKeyMobile.currentState?.openDrawer();
            //   },
            // )
            //     : null,
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const AppBarSearchButton(
                buttonHasTwoStates: true,
                searchIcon: Icons.search,
                searchActiveButtonColor: primaryColor,
              ),
              TextIconButton(
                showTitle: !Responsive.isMobile(context),
                icon: icon,
                title: buttonTitle,
                action: onPressed,
              ),
            ]);
      });
}