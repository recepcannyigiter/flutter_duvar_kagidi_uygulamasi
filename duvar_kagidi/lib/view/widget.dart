import 'package:flutter/material.dart';

baslik(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text("MR",style: TextStyle(color: Colors.blue),),
      Text("  Duvar Kağıdı",style: TextStyle(color: Colors.black),)
    ],
  );
}