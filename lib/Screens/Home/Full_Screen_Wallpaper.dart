//@dart=2.9

// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper/Screens/Model/ImageClas.dart';

// ignore: camel_case_types
class Full_Wallpaper extends StatefulWidget {
  final String image;

  const Full_Wallpaper({Key key, this.image}) : super(key: key);

  @override
  State<Full_Wallpaper> createState() => _Full_WallpaperState();
}

// ignore: camel_case_types
class _Full_WallpaperState extends State<Full_Wallpaper> {
  bool _isImageDownloaded = false;
  bool isselect = true;
  int _selectedWallpaperType;

  final ImageSaver saveImage = ImageSaver();

  Future<void> requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
    } else if (permissionStatus.isDenied) {
      PermissionStatus newPermissionStatus = await Permission.storage.request();
      if (newPermissionStatus.isGranted) {
      } else {}
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  DeviceInfo() {
    if (Platform.isAndroid) {
      setState(() {
        isselect = true;
      });
    } else if (Platform.isIOS) {
      setState(() {
        isselect = false;
      });
    }
  }

  void _showMenuDialogWithTimer() {
    menudialog();
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    DeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: widget.image.startsWith('http')
              ? DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  isselect == true
                      ? GestureDetector(
                          onTap: SharePressed,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: const Icon(
                              Icons.share,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isImageDownloaded = true;
                    });

                    widget.image.startsWith('http')
                        ? saveImage.saveImage(widget.image, _isImageDownloaded,
                            _selectedWallpaperType)
                        : saveImage.createWallpaperFolder(widget.image,
                            _isImageDownloaded, _selectedWallpaperType);
                    _showMenuDialogWithTimer();
                  },
                  child: Container(
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.download, color: Colors.white, size: 22),
                        Text(
                          "Download",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isselect == true
                    ? GestureDetector(
                        onTap: () {
                          if (_isImageDownloaded) {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              builder: (context) => _bottomSheetBar(),
                            );
                          } else {
                            _downloadImageDialog();
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.image_outlined,
                                  color: Colors.white, size: 22),
                              Text(
                                "Set Wallpaper",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: SharePressed,
                        child: Container(
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.share, color: Colors.white, size: 22),
                              Text(
                                "Share",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 30,
            right: MediaQuery.of(context).size.width / 30,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Set As Wallpaper",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 30,
                    )
                  ],
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    RadioListTile(
                      title: const Text('Home Screen'),
                      value: WallpaperManager.HOME_SCREEN,
                      activeColor: Colors.red,
                      groupValue: _selectedWallpaperType,
                      onChanged: (value) {
                        setState(() {
                          _selectedWallpaperType = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Lock Screen'),
                      value: WallpaperManager.LOCK_SCREEN,
                      groupValue: _selectedWallpaperType,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _selectedWallpaperType = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Both Lock & Home Screen'),
                      value: WallpaperManager.BOTH_SCREEN,
                      groupValue: _selectedWallpaperType,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _selectedWallpaperType = value;
                        });
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.image.startsWith('http')) {
                      saveImage.saveImage(widget.image, _isImageDownloaded,
                          _selectedWallpaperType);
                    } else {
                      saveImage.createWallpaperFolder(widget.image,
                          _isImageDownloaded, _selectedWallpaperType);
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  menudialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'Image Has been Downloading...',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  finalDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'Image Has been Downloaded',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  _downloadImageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Set As Wallpaper'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Firstly download Image'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void SharePressed() {
    Share.share(widget.image);
  }
}
