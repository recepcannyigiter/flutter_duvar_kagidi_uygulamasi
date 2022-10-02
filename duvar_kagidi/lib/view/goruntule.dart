import 'package:flutter/material.dart';

class Goruntule extends StatefulWidget {
  Goruntule({Key? key,required this.baslik,required this.sayfa}) : super(key: key);
  String baslik = "";
  var sayfa;
  @override
  State<Goruntule> createState() => _GoruntuleState();
}

class _GoruntuleState extends State<Goruntule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.baslik),
      ),
      body: widget.sayfa,
    );
  }
}
