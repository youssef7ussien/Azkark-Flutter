import 'aya.dart';
import '../../providers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlAyat extends StatefulWidget 
{
  final String surah;
  final double fontSize;
  
  AlAyat({
    this.surah,
    this.fontSize,
  });

  @override
  _AlAyatState createState() => _AlAyatState();
}

class _AlAyatState extends State<AlAyat> 
{

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final prayerProvider=Provider.of<PrayerProvider>(context,listen: false);
    
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: prayerProvider.getAyatSurah(widget.surah).length,
      itemBuilder: (context, index){
        return Aya(
          prayer: prayerProvider.getPrayer(prayerProvider.getAyaOfSurah(widget.surah,index)),
          fontSize: widget.fontSize,
        );
      },
    );
  }
}