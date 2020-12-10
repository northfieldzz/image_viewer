import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      title: 'Sample',
      home: SamplePage(title: 'Image Viewer'),
    );
  }
}

class SamplePage extends StatefulWidget {
  SamplePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SamplePageState createState() => SamplePageState();
}

class SamplePageState extends State<SamplePage> {
  File _image;
  final picker = ImagePicker();

  Future _getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future _getCameraRollImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image),
          ],
        ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: _getCameraRollImage,
              child: Icon(Icons.add_photo_alternate_outlined),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              onPressed: _getCameraImage,
              child: Icon(Icons.add_a_photo_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
