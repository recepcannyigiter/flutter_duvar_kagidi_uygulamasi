import 'dart:convert';
import 'package:duvar_kagidi/menu/arabalar.dart';
import 'package:duvar_kagidi/menu/bisiklet.dart';
import 'package:duvar_kagidi/menu/doga.dart';
import 'package:duvar_kagidi/menu/motivasyon.dart';
import 'package:duvar_kagidi/menu/muzik.dart';
import 'package:duvar_kagidi/menu/oyun.dart';
import 'package:duvar_kagidi/menu/spor.dart';
import 'package:duvar_kagidi/view/arama.dart';
import 'package:duvar_kagidi/view/goruntule.dart';
import 'package:duvar_kagidi/view/kategori.dart';
import 'package:duvar_kagidi/view/sec.dart';
import 'package:duvar_kagidi/view/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

class DuvarKagidi extends StatefulWidget {
  const DuvarKagidi({Key? key}) : super(key: key);

  @override
  State<DuvarKagidi> createState() => _DuvarKagidiState();
}

class _DuvarKagidiState extends State<DuvarKagidi> {
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
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
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
    String url = "https://api.pexels.com/v1/curated?per_page=80&page=$sayfa";
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
    List<CategorieModel> model = CategorieModel.getCategories();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: baslik(),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  if (isloaded) {
                    _intersitialAd.show();
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AramaEkrani()));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _initAd();
                        if (isloaded) {
                          _intersitialAd.show();
                        }
                      });
                      List sayfalar = [
                        const Oyun(),
                        const Muzik(),
                        const Doga(),
                        const Spor(),
                        const Motivasyon(),
                        const Bisiklet(),
                        const Arabalar()
                      ];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Goruntule(
                                    baslik: model[index].categorieName,
                                    sayfa: sayfalar[index],
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                model[index].imgUrl,
                                height: 60,
                                width: 120,
                                fit: BoxFit.cover,
                              )),
                          Container(
                              height: 60,
                              width: 120,
                              alignment: Alignment.center,
                              color: Colors.black26,
                              child: Text(
                                model[index].categorieName,
                                style: const TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "  Öne Çıkan Fotoğraflar",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                          images[index]["src"]["large2x"],
                          fit: BoxFit.cover,
                        ),
                      ));
                },
              ),
            ),
            InkWell(
              onTap: () {
                if (isloaded) {
                  _intersitialAd.show();
                }
                devamEt();
              },
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
      ),
    );
  }
}
