// ignore_for_file: camel_case_types, import_of_legacy_library_into_null_safe, file_names

import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/Model/ImageClas.dart';

class Popular_Wallpaper extends StatefulWidget {
  const Popular_Wallpaper({Key? key}) : super(key: key);

  @override
  State<Popular_Wallpaper> createState() => _Popular_WallpaperState();
}

class _Popular_WallpaperState extends State<Popular_Wallpaper> {
  List<PoplularImages> image = [
    PoplularImages("AI", "images/Category/AI.png"),
    PoplularImages("Animal", "images/Category/Animal.png"),
    PoplularImages("Bird", "images/Category/Bird.png"),
    PoplularImages("Black & White", "images/Category/Black&White.png"),
    PoplularImages("Art", "images/Category/Art.png"),
    PoplularImages("Plants", "images/Category/Plants.png"),
    PoplularImages("Fashion", "images/Category/Fashion.png"),
    PoplularImages("Food", "images/Category/Food.png"),
    PoplularImages("Flower", "images/Category/Flower.png"),
    PoplularImages("Music", "images/Category/music.png"),
    PoplularImages("Iphone 14", "images/Category/iphone.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: image.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image[index].image),
                        fit: BoxFit.cover,
                        opacity: 0.7)),
                child: Center(
                  child: Text(
                    image[index].name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
