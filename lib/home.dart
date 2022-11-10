import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/services.dart';
import 'package:hotstar/Modul.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gridview_menu/gridview_menu.dart';
import 'package:hotstar/inner.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 1);
    _initImages();
  }


  //  Image Load using Fututre Builder

  Future<List<String>?> _initImages() async {

    List<String>? someimages;

    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/latest/'))
        .where((String key) => key.contains('.webp'))
        .toList();

      someimages = imagePaths;

      return someimages;
  }

  List<String> no = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131313),
      drawer: Icon(Icons.menu_rounded),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'images/hotd.png',
          alignment: Alignment.center,
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: 200,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: Modul().image.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0))),
                          child: Image.asset(
                            '$i',
                            fit: BoxFit.fill,
                          ));
                    },
                  );
                }).toList(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return inner();
                  },));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  height: 30,
                  child: Text(
                    "Latest & Trending",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              Container(
                height: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    color: Colors.white70,
                    alignment: Alignment.center,
                    iconSize: 20),
              ),
            ],
          ),


          //  Image Load using Fututre Builder

          Container(
            margin: EdgeInsets.only(left: 10),
            height: 150,
            width: 120,
            child: FutureBuilder(future: _initImages(),builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.done)
                {
                    if(snapshot.hasData)
                      {
                        List<String>? someimages = snapshot.data as List<String>?;

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: someimages!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return inner();
                                  },));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 150,
                                  width: 120,
                                  decoration: ShapeDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(someimages[index]),
                                          fit: BoxFit.fill),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                              );
                            },
                          );
                      }
                    else if(snapshot.hasError)
                      {
                          return Center(child: Text("Data Error"));
                      }
                    else
                      {
                          return Center(child: Text("No data Found"),);
                      }
                }

              return Center(child: CircularProgressIndicator(color: Colors.white,),);
            },)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 30,
                child: Text(
                  "Continue Watching",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Container(
                height: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    color: Colors.white70,
                    alignment: Alignment.center,
                    iconSize: 20),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 100,
            width: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Modul.Continue.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 100,
                  width: 200,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Modul.Continue[index]),
                          fit: BoxFit.fill),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 30,
                child: Text(
                  "Top 10 in India Today - English",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Container(
                height: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    color: Colors.white70,
                    alignment: Alignment.center,
                    iconSize: 20),
              ),
            ],
          ),

          FutureBuilder(future: _initImages(),builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.done)
              {
                  if(snapshot.hasData)
                    {
                      List<String>? someimages = snapshot.data;
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 150,
                        width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  height: 200,
                                  width: 120,
                                  decoration: ShapeDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(someimages![index]),
                                          fit: BoxFit.fill),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                                Positioned(
                                  top: 60,
                                  left: 13,
                                  child: Container(
                                      child: Text(
                                        "${no[index]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    }
                  else
                    {
                       return Center(child: Text("No Data Found",style: TextStyle(color: Colors.white),),);
                    }

              }

            return Center(child: CircularProgressIndicator(color: Colors.white,),);
          },)
          // MobileSidebar(items: ,breakPoint: 3000,showList: ,)
        ],
      ),
    );
  }
}
