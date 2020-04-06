import 'package:flutter/material.dart';
import '../utilities/colors.dart';

class LoadingCircularProgress extends StatelessWidget 
{


  @override
  Widget build(BuildContext context) 
  {

    
    return  Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ruby),
          strokeWidth: 3.0,
        ),
    );
  }
}