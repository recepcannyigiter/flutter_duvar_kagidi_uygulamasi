import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import '../view/sec.dart';

class Bisiklet extends StatefulWidget {
  const Bisiklet({Key? key}) : super(key: key);

  @override
  State<Bisiklet> createState() => _BisikletState();
}

class _BisikletState extends State<Bisiklet> {
  List images = [];
  int sayfa = 1;

  @override
  void initState() {
    fetchApi();
    _initAd();
    super.initState();
  }

  late InterstitialAd _intersitialAd;
  bool isloaded = false;

  void _initAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-1813338595147221/4417161427",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _intersitialAd = ad;
            isloaded = true;
          },
          onAdFailedToLoad: (error) {}),
    );
  }

  fetchApi() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=bikes&per_page=80"),
        headers: {
          'Authorization':
              '563492ad6f91700001000001143edf11281445a3a7963d953a16d319'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
    });
  }

  devamEt() async {
    setState(() {
      sayfa = sayfa + 1;
    });
    String url =
        "https://api.pexels.com/v1/search?query=bikes&per_page=80&page=$sayfa";
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001143edf11281445a3a7963d953a16d319'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result["photos"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (isloaded) {
                      _intersitialAd.show();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Secim(
                                  foto: images[index]["src"]["large2x"],
                                  isim: images[index]["photographer"],
                                )));
                  },
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      images[index]["src"]["tiny"],
                      fit: BoxFit.cover,
                    ),
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
                  "Daha fazla fotoğraf yükle",
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
