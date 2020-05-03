import 'package:azkark/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget 
{
  // final List<Widget> children;

  // const CustomTabBar({
  //   this.children
  // });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin 
{
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller=AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    double childWidth=(size.width-16)/2;
    return SafeArea(
      child: Container(
        width: size.width,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            buildAnimatedBackGround(childWidth),
            AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return buildBottomText(
                  () { controller.reverse(); }
                  ,'الآيات', childWidth, 0,animation.value>.5? Colors.black:Colors.white);
              }
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return buildBottomText(
                  () { controller.forward(); }
                  ,'السور', childWidth, childWidth, animation.value<.5? Colors.black:Colors.white);
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomText(Function onTap,String text, double width, double left, Color color) {
    return Positioned(
      left: left,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: width,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedBackGround(double childWidth) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) 
      {
        return Positioned(
          height: 40,
          left: animation.value>0.5 ? childWidth*2*(animation.value-0.5) : 0,
          child: Container(
            width: animation.value<0.5 ? childWidth*2*(animation.value+0.5)
            : childWidth*2*(animation.value+0.5+((0.5-animation.value)*2)),
            decoration: BoxDecoration(
              color: ruby,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          ),
        );
      }
    );
  }
}