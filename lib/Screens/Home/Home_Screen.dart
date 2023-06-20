//@dart=2.9
// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/Home/Full_Screen_Wallpaper.dart';
import 'package:wallpaper/Screens/Home/Third_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// ignore: duplicate_ignore
class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "images/Home/1.png",
    "images/Home/2.png",
    "images/Home/3.png",
    "images/Home/4.png",
    "images/Home/5.png",
    "images/Home/6.png",
    "images/Home/7.png",
  ];

  List<String> images2 = [
    "images/PageImages/8.png",
    "images/PageImages/9.png",
    "images/PageImages/10.png",
    "images/PageImages/11.png",
    "images/PageImages/12.png",
    "images/PageImages/13.png",
    "images/PageImages/14.png",
    "images/PageImages/15.png",
    "images/PageImages/16.png",
    "images/PageImages/17.png",
  ];

  final List<String> imageList = [
    "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Generated Wallpaper",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(child: Text("HOME")),
              Tab(child: Text("LIVE")),
              Tab(child: Text("EXCLUSIVE")),
              Tab(child: Text("AI ART")),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                _Page1View(),
                _Page2View(),
                _Page3View(),
                _Page4View(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Page1View() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 150,
                reverse: false,
                aspectRatio: 5.0,
              ),
              itemBuilder: (context, i, id) {
                if (imageList[i] == null || imageList[i].isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      // ClipRRect for image border radius
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          imageList[i],
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Full_Wallpaper(image: imageList[i])),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Collections",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: images2.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index < 3) {
                  // Show only the first three containers
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(images2[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const [
                            Expanded(child: SizedBox()),
                            Text(
                              "Dark Abstracts",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "planet, abstract, back...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (index == 3) {
                  // Show the "See More" container
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the new page when "See More" is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Popular_Wallpaper()),
                        );
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors
                              .grey, // Customize the background color of the "See More" container
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_forward),
                              Text(
                                "See More",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // Hide the remaining containers beyond index 3
                  return Container();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 16,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Full_Wallpaper(image: images[index]),
                      ));
                    },
                    child: Image(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _Page2View() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: images2.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Full_Wallpaper(image: images2[index]),
                  ));
                },
                child: Image(
                  image: AssetImage(images2[index]),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _Page3View() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: images2.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Full_Wallpaper(image: images2[index]),
                  ));
                },
                child: Image(
                  image: AssetImage(images2[index]),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _Page4View() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: images2.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Full_Wallpaper(image: images2[index]),
                  ));
                },
                child: Image(
                  image: AssetImage(images2[index]),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
