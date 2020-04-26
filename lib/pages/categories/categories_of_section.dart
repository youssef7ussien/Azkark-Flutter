import 'package:azkark/models/section_model.dart';
import 'package:azkark/widgets/Custom_drawer/custom_drawer.dart';

import '../../utilities/background.dart';
import '../../widgets/categories_widget/category.dart';
import '../../providers/sections_provider.dart';
import '../../providers/categories_provider.dart';
import 'package:provider/provider.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class CategoriesOfSection extends StatefulWidget
{
  int _sectionId;

  CategoriesOfSection(this._sectionId);

  @override
  _CategoriesOfSectionState createState() => _CategoriesOfSectionState();
}

class _CategoriesOfSectionState extends State<CategoriesOfSection> with SingleTickerProviderStateMixin 
{
  bool isCollapsed;
  AnimationController animationController;

  @override
  void initState() 
  {
    super.initState();
    animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 225)
    );
    isCollapsed=false;
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final sectionsProvider=Provider.of<SectionsProvider>(context,listen: false);
    final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              sectionsProvider.getSection(widget._sectionId).name,
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.all(4.0),
                child: IconButton(
                  color: ruby[50],
                  highlightColor: ruby[700],
                  splashColor: ruby[700],
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(Icons.search),
                  onPressed: (){}
                ),
              ),
              _buildMenuButton(),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: size.width*0.85,
                  height: size.height,
                  child: Column(
                    children: <Widget>[
                      // _buildTopBox(categoriesProvider,sectionsProvider.getCategoriesIndex(_sectionId).length,size),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: sectionsProvider.getCategoriesIndex(widget._sectionId).length,
                          itemBuilder:  (context, index){
                            return Padding(
                              padding: index==0 ? 
                                const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
                                : index==sectionsProvider.getCategoriesIndex(widget._sectionId).length-1 ?
                                const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
                                : const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Category(
                                categoriesProvider.getCategory(sectionsProvider.getCategoriesIndex(widget._sectionId)[index]),
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CustomDrawer(
                  animationController: animationController,
                  minWidth: size.width*0.15,
                  maxWidth: size.width*0.6,
                  onTap: (){
                    setState(() {
                      isCollapsed=!isCollapsed;
                      isCollapsed ? animationController.forward() : animationController.reverse();
                    });
                  }
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }

  Widget _buildMenuButton()
  {
    return Padding(
      padding: EdgeInsets.only(left:5.0),
      child: IconButton(
        highlightColor: ruby[700],
        splashColor: ruby[700],
        onPressed: () {
          setState(() {
            isCollapsed=!isCollapsed;
            isCollapsed ? animationController.forward() : animationController.reverse();
          });
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: animationController,
          color: ruby[50],
        ),
      ),
    );
  }

}
