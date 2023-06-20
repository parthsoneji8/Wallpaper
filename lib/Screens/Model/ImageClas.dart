//@dart=2.9
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaver {
  bool abstract = false;
  int assetvalue;

  Future<void> saveImage(String imageUrl, bool downlaod, int valueSet) async {

    abstract = downlaod;
    assetvalue = valueSet;

    final response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final bytes = Uint8List.fromList(response.data);

    final directory = await DownloadsPathProvider.downloadsDirectory;

    final wallpaperFolder = Directory('${directory.path}/Wallpaper');

    if (!(await wallpaperFolder.exists())) {
      await wallpaperFolder.create(recursive: true);
    }

    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    File filePath = File('${wallpaperFolder.path}/$fileName');

    await filePath.writeAsBytes(bytes);

    await ImageGallerySaver.saveFile(filePath.path);

    if (assetvalue != null) {
      setWallpaper(filePath.path);
    }
  }

  void createWallpaperFolder(String image, bool downlaod, valueSet) async {

    Directory downloadDir = await DownloadsPathProvider.downloadsDirectory;

    abstract = downlaod;
    assetvalue = valueSet;

    if (downloadDir != null) {
      String downloadPath = downloadDir.path;

      Directory wallpaper = Directory('$downloadPath/Wallpaper');

      if (!(await wallpaper.exists())) {
        wallpaper.create(recursive: true);
      }
      await downloadAndSaveImage(wallpaper, image);
    }
    else {}
  }

  Future<void> downloadAndSaveImage(final Directory wallpaper, String image) async {

    String assetImagePath = image;

    List<String> assetImagePathParts = assetImagePath.split('/');
    String imageName = assetImagePathParts.last;

    ByteData imageBytes = await rootBundle.load(assetImagePath);
    List<int> bytes = imageBytes.buffer.asUint8List();

    File imageFile = File("${wallpaper.path}/$imageName");
    await imageFile.writeAsBytes(bytes);

    if (assetvalue != null) {
      setWallpaper(imageFile.path);
    }
  }

  Future<void> setWallpaper(String imagePath) async {
    if (!abstract) {
      return;
    }
    if (assetvalue == null) {
      return;
    }
    try {
      await WallpaperManager.setWallpaperFromFile(
        imagePath,
        assetvalue,
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}

class PoplularImages {
  String name;
  String image;

  PoplularImages(this.name, this.image);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
