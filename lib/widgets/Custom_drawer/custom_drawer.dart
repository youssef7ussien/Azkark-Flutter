import '../../utilities/colors.dart';
import 'list_title_of_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/sections_provider.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget 
{
  final double maxWidth , minWidth;
  final Function onTap;
  final AnimationController animationController;
  
  CustomDrawer({
    @required this.animationController,
    @required this.minWidth,
    @required this.maxWidth,
    this.onTap,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin 
{
  double maxWidth;
  double minWidth;
  Animation<double> widthAnimation;
  Animation<double> shadowAnimation;
  int currentSelectedIndex;

  @override
  void initState() 
  {
    super.initState();
    currentSelectedIndex=0;
    minWidth=widget.minWidth;
    maxWidth=widget.maxWidth;
    widthAnimation=Tween<double>(
      begin: minWidth,
      end: maxWidth
    ).animate(widget.animationController);
    shadowAnimation=Tween<double>(
      begin: 0,
      end: 0.4
    ).animate(widget.animationController);
  }

  AnimationController get animationController => widget.animationController;
  Function get onTap => widget.onTap;

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final sectionsProvider=Provider.of<SectionsProvider>(context,listen: false);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, widget){
        return Stack(
          children: <Widget>[
            if(widthAnimation.value!=minWidth)
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onTap,
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: ruby[900].withOpacity(shadowAnimation.value)
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: widthAnimation.value,
                color: ruby,
                child: Column(
                  children: <Widget>[
                    // DrawerListTitle(),
                    // Divider(color: Colors.grey, height: 40.0,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sectionsProvider.length,
                        itemBuilder: (context, index) {
                          return DrawerListTitle(
                              onTap: () {
                                setState(() {
                                  currentSelectedIndex=index;
                                });
                              },
                              isSelected: currentSelectedIndex==index,
                              title: sectionsProvider.getSection(index).name,
                              pathIcon:
                                currentSelectedIndex==index ? 
                                'assets/images/sections/'+sectionsProvider.getSection(index).id.toString()+'_128px.png'
                                : 'assets/images/sections/'+sectionsProvider.getSection(index).id.toString()+'_white_128px.png',
                              animationController: animationController,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}