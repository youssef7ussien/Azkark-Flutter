import '../../providers/sebha_provider.dart';
import '../../widgets/sebha_widget/tasbih.dart';
import '../../widgets/favorites_widget/empty_favorite.dart';
import '../../utilities/colors.dart';
import '../../providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../../utilities/background.dart';
import 'package:flutter/material.dart';

class ViewFavoriteSebha extends StatefulWidget 
{

  @override
  _ViewFavoriteSebhaState createState() => _ViewFavoriteSebhaState();
}

class _ViewFavoriteSebhaState extends State<ViewFavoriteSebha> 
{
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final sebhaProvider=Provider.of<SebhaProvider>(context,listen: false);
    final favoritesProvider=Provider.of<FavoritesProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'المفضلة',
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: favoritesProvider.isEmpty(2) ? EmptyFavorite() : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: favoritesProvider.length(2),
            itemBuilder:  (context, index){
              return Padding(
                padding: index==0 ? 
                  const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
                  : index==favoritesProvider.length(2)-1 ?
                  const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
                  : const EdgeInsets.only(left: 5.0,right: 5.0),
                child: Tasbih(
                  sebhaProvider.getItemSebha(favoritesProvider.getItemId(2,index)),
                ),
              );
            }
          ),
        ),
      ]
    );
  }
}