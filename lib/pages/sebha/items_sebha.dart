import '../../widgets/sebha/name_tasbih.dart';
import '../../providers/sebha_provider.dart';
import '../../utilities/background.dart';
import 'package:provider/provider.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class ItemsSebha extends StatelessWidget
{

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final sebhaProvider=Provider.of<SebhaProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'المسبحة',
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                child: IconButton(
                  color: ruby10,
                  highlightColor: ruby80,
                  splashColor: ruby80,
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(Icons.search),
                  onPressed: (){}
                ),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: sebhaProvider.length,
            itemBuilder:  (context, index){
              return Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Tasbih(
                  sebhaProvider.getItemSebha(index),
                ),
              );
            },
          ),
        ),
      ]
    );
  }
}