import 'package:flutter/material.dart';

class GameButton{
  int id;
  String text;
  Color bgColor;
  bool isEnabled;

  GameButton({this.id, this.text="",this.bgColor=Colors.grey,this.isEnabled=true});
}
