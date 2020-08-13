import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageInputWidget extends StatefulWidget {
  final Function onSelectImage;
  ImageInputWidget(this.onSelectImage);
  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File _image;
  final _picker = ImagePicker();
  Directory appDir;

  Future<void> _getImage() async {
    /// take the picture
    final _imagePicker = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (_imagePicker == null) return;

    /// store it to _image
    setState(() {
      _image = File(_imagePicker.path);
    });

    /// get the application storage dir
    try {
      appDir = await getApplicationDocumentsDirectory();
    } catch (e) {
      print(e);
      print("got exception at path provider, need emulator restart");
    }

    /// get the file name from _image that's from camera
    final fileName = path.basename(_image.path);

    /// copy camera image into the application storage and keep the same file name
    final savedImage =
        await File(_imagePicker.path).copy("${appDir.path}/$fileName");

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: (_image != null)
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image yet',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _getImage,
          ),
        ),
      ],
    );
  }
}
