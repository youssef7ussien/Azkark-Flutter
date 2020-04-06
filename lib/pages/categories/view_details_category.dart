import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget 
{

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        _buildBackgroundImage(size),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              '',
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              _buildSearchBar(size),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(Size size)
  {
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

  Widget _buildSearchBar(Size size)
  {
    return InkWell(
      onTap: (){
        print('You click on search');
      },
      child: Container(
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ruby,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: size.height*0.055,
          decoration: BoxDecoration(
            color: ruby80,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: ruby10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'إبحث عن ذكر . . . ',
                  style: TextStyle(
                    color: ruby30,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }

}