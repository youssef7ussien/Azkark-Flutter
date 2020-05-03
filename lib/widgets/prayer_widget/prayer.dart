import 'package:azkark/providers/prayer_provider.dart';
import 'package:azkark/utilities/colors.dart';
import 'package:azkark/widgets/prayer_widget/surah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alayat.dart';

class Prayer extends StatefulWidget 
{
  final double fontSize;
  final bool showAlAyat;
  final int surahNumber;
  final Function onTap;

  Prayer({
    this.fontSize,
    this.surahNumber,
    this.onTap,
    this.showAlAyat,
  });

  @override
  _PrayerState createState() => _PrayerState();
}

class _PrayerState extends State<Prayer>
{
  
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size; 
    final prayerProvider=Provider.of<PrayerProvider>(context,listen: false);
    
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          Surah(
            fontSize: widget.fontSize,
            number: widget.surahNumber+1,
            surah: prayerProvider.allSurah[widget.surahNumber],
            onTap: widget.onTap,
            showAlAyat: widget.showAlAyat,
          ),
          if(widget.showAlAyat)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AlAyat(
              fontSize: widget.fontSize,
              surah: prayerProvider.allSurah[widget.surahNumber],
            ),
          ),
        ],
      ),
    );
  }

}