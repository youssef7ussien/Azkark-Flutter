import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class DrawerListTitle extends StatefulWidget 
{
  final String title, pathIcon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  DrawerListTitle({
    @required this.title,
    @required this.pathIcon,
    @required this.animationController,
    this.isSelected=false,
    this.onTap
  });

  @override
  _DrawerListTitleState createState() => _DrawerListTitleState();
}

class _DrawerListTitleState extends State<DrawerListTitle> 
{
  Animation<double> widthAnimation,fontSizeAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation=Tween<double>(
      begin: 70, 
      end: 200
    ).animate(widget.animationController);
    fontSizeAnimation=Tween<double>(
      begin: 0, 
      end: 14
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widthAnimation.value,
        height: size.height*0.08,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: _buildNameSection()
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildImageSection()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameSection()
  {
    return Container(
      padding: widget.isSelected ? EdgeInsets.only(right: 5.0) : EdgeInsets.all(0.0),
      child: Text(
        '${widget.title}',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: fontSizeAnimation.value,
          color: widget.isSelected ? ruby[900] : ruby[50],
        ),
      ),
    );  
  }

  Widget _buildImageSection()
  {
    return Image.asset(
      widget.pathIcon,
      fit: BoxFit.contain,
    );
  }
}