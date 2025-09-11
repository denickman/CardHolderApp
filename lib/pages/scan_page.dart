
import 'package:flutter/material.dart'; 
import 'package:image_picker/image_picker.dart';


class ScanPage extends StatefulWidget {

  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                    getImage(ImageSource.camera);  
                },
                icon: const Icon(Icons.camera),
                label: const Text('Capture')
              ),

              TextButton.icon(
                onPressed: () {
                   getImage(ImageSource.gallery);  
                },
                icon: const Icon(Icons.photo_album),
                label: const Text('Gallery')
              ),
            ],
          )
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xfile = await ImagePicker().pickImage(source: camera);
    if (xfile != null) {
      print('>> PATH: ${xfile.path}');
    }
  }
}