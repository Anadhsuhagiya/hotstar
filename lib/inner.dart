import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inner extends StatefulWidget {

  inner();


  @override
  State<inner> createState() => _innerState();
}

class _innerState extends State<inner> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initImages();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/latest/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      latestin = imagePaths;
    });
  }

  List<String> latestin = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131313),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'images/hotd.png',
          alignment: Alignment.center,
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          height: 300,
          child: Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
            decoration: ShapeDecoration(
              image: DecorationImage(image: AssetImage('')),
              color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          )),
    );
  }
}
