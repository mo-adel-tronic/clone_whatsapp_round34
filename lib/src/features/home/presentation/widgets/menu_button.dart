import 'package:flutter/material.dart';
    enum MenuSelection { optionOne, optionTwo, optionThree,optionFour,optionFive }

class MenuButton {
  static  List<PopupMenuEntry<MenuSelection>> menuItems = [
    PopupMenuItem<MenuSelection>(
      value: MenuSelection.optionOne,
      child: Text('New Contact'),
    ),
    PopupMenuItem<MenuSelection>(
      value: MenuSelection.optionTwo,
      child: Text('New Group'),
    ),
    PopupMenuItem<MenuSelection>(
      value: MenuSelection.optionThree,
      child: Text('Linked Devices'),
    ),
    PopupMenuItem<MenuSelection>(
      value: MenuSelection.optionFour,
      child: Text('Starred Messages'),
    ),
    PopupMenuItem<MenuSelection>(
      value: MenuSelection.optionFive,
      child: Text('Settings'),
    ),

  ];
}