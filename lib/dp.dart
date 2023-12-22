import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pallet.dart';

class AssisImage {
  static Stack assistantImage({double height = 120,double width = 120}){
    return Stack(
      children: [
        Center(
          child: Container(
            height: height,
            width: width,
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              color: Pallet.circleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          height: height*1.025,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/virtualAssistant.png'),
              ),
          ),
        ),
      ],
    );
  }

  static Stack userImage({double height = 120,double width = 120}){
    return Stack(
      children: [
        Center(
          child: Container(
            height: height,
            width: width,
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              color: Pallet.circleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          height: height*1.025,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.account_circle,size: 50.0,)
        ),
      ],
    );
  }
}