import '../../pages/sebha/sebha_page.dart';
import '../../models/sebha_model.dart';
import '../../providers/categories_provider.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tasbih extends StatefulWidget 
{
  final SebhaModel _tasbih;
  
  Tasbih(this._tasbih);

  @override
  _TasbihState createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> 
{
  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    // final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

    return Card(
      color: ruby30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 60,
        width: size.width,
        child: InkWell(
          highlightColor: ruby20,
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            print('${widget._tasbih.nameWithDiacritics}');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child : SebhaPage(widget._tasbih),
                );
              }),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildNameField(size)
                    ),
                    _buildFavoriteButton(),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(Size size)
  {
    return Container(
      width: size.width*0.8,
      // height: 40,
      child: Text(
        widget._tasbih.nameWithDiacritics,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
          color: ruby,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton()
  {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: ruby40,
        splashColor: ruby40,
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          print('You clicked on Edit');
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.edit,
            size: 19,
            color: ruby,
          ),
        ),
      ),
    );
  }

}