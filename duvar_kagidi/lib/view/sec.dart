import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class Secim extends StatefulWidget {
  final String foto;
  final String isim;

  const Secim({
    Key? key,
    required this.foto,
    required this.isim,
  }) : super(key: key);
  @override
  State<Secim> createState() => _SecimState();
}

enum Menu {
  anaekran,
  kilitekrani,
  ikiside,
}

class _SecimState extends State<Secim> {
  Future<void> anaEkran() async {
    var mesaj =
        const SnackBar(content: Text("Duvar kağıdı Ana Ekran'a Ayarlandı!"));
    int location = WallpaperManagerFlutter.HOME_SCREEN;
    var dosya = await DefaultCacheManager().getSingleFile(widget.foto);
    await WallpaperManagerFlutter().setwallpaperfromFile(dosya, location);
    ScaffoldMessenger.of(context).showSnackBar(mesaj);
  }

  Future<void> kilitEkrani() async {
    var mesaj =
        const SnackBar(content: Text("Duvar kağıdı Kilit ekranına Ayarlandı!"));
    int location = WallpaperManagerFlutter.LOCK_SCREEN;
    var dosya = await DefaultCacheManager().getSingleFile(widget.foto);
    await WallpaperManagerFlutter().setwallpaperfromFile(dosya, location);
    ScaffoldMessenger.of(context).showSnackBar(mesaj);
  }

  Future<void> ikisiDe() async {
    var mesaj =
        const SnackBar(content: Text("Duvar kağıdı İki ekrana da Ayarlandı!"));
    int location = WallpaperManagerFlutter.BOTH_SCREENS;
    var dosya = await DefaultCacheManager().getSingleFile(widget.foto);
    await WallpaperManagerFlutter().setwallpaperfromFile(dosya, location);
    ScaffoldMessenger.of(context).showSnackBar(mesaj);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(widget.foto))),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    EvaIcons.arrowBack,
                    color: Color(0XFF4380b1),
                  )),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              PopupMenuButton(
                onSelected: ((value) {
                  if (value == Menu.anaekran) {
                    anaEkran();
                  } else if (value == Menu.kilitekrani) {
                    kilitEkrani();
                  } else if (value == Menu.ikiside) {
                    ikisiDe();
                  }
                }),
                itemBuilder: (context) => [
                  PopupMenuItem(value: Menu.anaekran, child: Text("Ana Ekran")),
                  PopupMenuItem(
                      value: Menu.kilitekrani, child: Text("Kilit Ekranı")),
                  PopupMenuItem(value: Menu.ikiside, child: Text("İkisi de")),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
