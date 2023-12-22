import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pallet.dart';

import 'dp.dart';

class FeatureBox extends StatelessWidget{
  FeatureBox({super.key, required this.fbname, required this.color, required this.descriptionText});


  final color;
  final String fbname;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(left: 15.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(fbname,
                style: TextStyle(
                  color: Pallet.fontColor,
                  fontFamily: 'Cera Pro',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(descriptionText,
                style: TextStyle(
                  color: Pallet.fontColor,
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class aiTextBox extends StatelessWidget{
  const aiTextBox({super.key, required this.msg,});

  final String msg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 45.0,
          width: 45.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0).copyWith(right: 0.0),
            child: AssisImage.assistantImage(),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0,left: 5.0),
              decoration: BoxDecoration(
                color: Pallet.aiChatBoxColor,
                border: Border.all(
                  color: Pallet.borderColor,
                ),
                borderRadius: BorderRadius.circular(20.0).copyWith(topLeft: Radius.zero),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  msg,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Cera Pro',
                    color: Pallet.fontColor,
                  ),),
              ),
            ),
          ),
        ),
      ],
    );
  }

}

class userTextBox extends StatelessWidget{
  const userTextBox({super.key, required this.msg,});

  final String msg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0,left: 5.0),
            decoration: BoxDecoration(
              color: Pallet.userChatBoxColor,
              border: Border.all(
                color: Pallet.borderColor,
              ),
              borderRadius: BorderRadius.circular(20.0).copyWith(topRight: Radius.zero),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0).copyWith(right: 0.0),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Cera Pro',
                  color: Pallet.fontColor,
                ),),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 45,
            maxHeight: 45,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0).copyWith(left: 0.0),
            child: const Icon(Icons.account_circle),
          ),
        ),
      ],
    );
  }

}