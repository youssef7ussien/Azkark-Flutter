import 'package:azkark/utilities/colors.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Container(
      color: ruby10,
      child: Image.asset(
        'assets/images/background/background.png',
        color: Color(0x1044000D),
        fit: BoxFit.cover,
        height: size.height,
      ),
    );
  }
}