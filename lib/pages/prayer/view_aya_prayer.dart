// import '../../widgets/scroll_indicator/scroll_indicator.dart';
// import '../../providers/settings_provider.dart';
// import '../../widgets/slider_font_size/button_font_size.dart';
// import '../../widgets/slider_font_size/slider_font_size.dart';
// import '../../widgets/prayer_widget/prayer.dart';
// import '../../providers/prayer_provider.dart';
// import '../../utilities/colors.dart';
// import 'package:provider/provider.dart';
// import '../../utilities/background.dart';
// import 'package:flutter/material.dart';

// class ViewAyaPrayer extends StatefulWidget 
// {
//   final double fontSize;

//   const ViewAyaPrayer({
//     this.fontSize
//   });
//   @override
//   _ViewAyaPrayerState createState() => _ViewAyaPrayerState();
// }

// class _ViewAyaPrayerState extends State<ViewAyaPrayer> 
// {

//   @override
//   Widget build(BuildContext context) 
//   {
//     final parayerProvider=Provider.of<PrayerProvider>(context,listen: false);

//     return ListView.builder(
//       physics: BouncingScrollPhysics(),
//       itemCount: parayerProvider.length,
//       itemBuilder:  (context, index){
//         return Padding(
//           padding: index==0 ?
//             const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
//             : index==parayerProvider.length-1 ?
//             const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
//             : const EdgeInsets.only(left: 5.0,right: 5.0),
//           child: Prayer(
//             fontSize:widget.fontSize,
//             prayer: parayerProvider.getPrayer(index),
//           ),
//         );
//       }
//     );
//   }
// }