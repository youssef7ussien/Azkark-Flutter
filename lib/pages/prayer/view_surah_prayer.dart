// import '../../widgets/prayer_widget/surah.dart';
// import '../../providers/prayer_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// class ViewSurahPrayer extends StatefulWidget 
// {
//   final double fontSize;

//   const ViewSurahPrayer({
//     this.fontSize
//   });

//   @override
//   _ViewSurahPrayerState createState() => _ViewSurahPrayerState();
// }

// class _ViewSurahPrayerState extends State<ViewSurahPrayer> 
// {
//   @override
//   Widget build(BuildContext context) 
//   {
//     final parayerProvider=Provider.of<PrayerProvider>(context,listen: false);

//     return ListView.builder(
//       physics: BouncingScrollPhysics(),
//       itemCount: parayerProvider.allSurah.length,
//       itemBuilder:  (context, index){
//         return Padding(
//           padding: index==0 ? 
//             const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
//             : index==parayerProvider.length-1 ?
//             const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
//             : const EdgeInsets.only(left: 5.0,right: 5.0),
//           child: Surah(
//             number: index+1,
//             fontSize: widget.fontSize,
//             surah: parayerProvider.allSurah[index],
//           ),
//         );
//       }
//     );
//   }
// }