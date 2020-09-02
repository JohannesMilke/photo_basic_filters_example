import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_basic_filters_example/color_filters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Basic Photo Filters',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MyHomePage(title: 'Basic Photo Filters'),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> imageBytes;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: pickImage,
            ),
          ],
        ),
        body: ColorFiltered(
          colorFilter: ColorFilters.invert,
          //colorFilter: ColorFilter.mode(Colors.orange, BlendMode.color),
          child: buildImage(),
        ),
      );

  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      this.imageBytes = File(image.path).readAsBytesSync();
    });
  }

  Widget buildImage() {
    return imageBytes != null ? Image.memory(imageBytes) : Container();
  }
}
