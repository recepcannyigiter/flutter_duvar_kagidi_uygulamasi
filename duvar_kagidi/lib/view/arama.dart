import 'dart:convert';

import 'package:duvar_kagidi/view/sec.dart';
import 'package:duvar_kagidi/view/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AramaEkrani extends StatefulWidget {
  const AramaEkrani({Key? key}) : super(key: key);


  @override
  State<AramaEkrani> createState() => _AramaEkraniState();
}

class _AramaEkraniState extends State<AramaEkrani> {
  TextEditingController textEditingController = TextEditingController();
  List arananfoto = [];
  bool aranannesne = false;
  int sayfa = 1;

  devamEt()async{
    setState((){
      sayfa = sayfa +1;
    });
    String aranan = textEditingController.text;
    String url = aranannesne == false ? "https://api.pexels.com/v1/curated?per_page=80&page=$sayfa" : "https://api.pexels.com/v1/search?query='$aranan'&per_page=80&page=$sayfa";
    await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
          '563492ad6f91700001000001143edf11281445a3a7963d953a16d319'
        }).then((value){
      Map result = jsonDecode(value.body);
      setState((){
       arananfoto.addAll(result["photos"]);
      });
    });
  }

  ara()async{
    String aranan = textEditingController.text;
    String url = "https://api.pexels.com/v1/search?query='$aranan'&per_page=1";
    await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
          '563492ad6f91700001000001143edf11281445a3a7963d953a16d319'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        arananfoto.addAll(result["photos"]);
        aranannesne = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: baslik(),
        iconTheme: const IconThemeData(
          color: Colors.black,
      ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 250,
              child: TextField(
                onTap: ara,
                controller: textEditingController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Duvar Kağıdı Ara....",
                    suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: arananfoto.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Secim(
                      foto: arananfoto[index]["src"]["large2x"],
                      isim: arananfoto[index]["photographer"],
                    )));
                  },
                  child: Container(
                    color: Colors.white,
                    child: Image.network(arananfoto[index]["src"]["tiny"],fit: BoxFit.cover,),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: devamEt,
            child: const SizedBox(
              height: 60,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Göster",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
