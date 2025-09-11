import 'package:cardholder/models/contact_model.dart';
import 'package:cardholder/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cardholder/customwidgets/drag_target_item.dart';
import 'package:cardholder/customwidgets/line_item.dart';
import 'package:cardholder/pages/form_page.dart';
import 'package:go_router/go_router.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = '';

  bool isScanOver = false;
  List<String> lines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          IconButton(
            onPressed: image.isEmpty ? null : createContact,
            icon: const Icon(Icons.arrow_forward),
          )
        ],
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
                label: const Text('Capture'),
              ),

              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_album),
                label: const Text('Gallery'),
              ),
            ],
          ),

          if (isScanOver)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DragTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.company,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    ),
                  ],
                ),
              ),
            ),

          if (isScanOver)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(hint),
            ),

          Wrap(children: lines.map((line) => LineItem(line: line)).toList()),
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xfile = await ImagePicker().pickImage(source: camera);
    if (xfile != null) {
      setState(() {
         image = xfile.path;
      });
     

      EasyLoading.show(status: "Please wait");
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      final recognizedText = await textRecognizer.processImage(
        InputImage.fromFile(File(xfile.path)),
      );
      EasyLoading.dismiss();

      final tempList = <String>[];

      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }

      setState(() {
        lines = tempList;
        isScanOver = true;
      });
    }
  }

  getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;

      case ContactProperties.mobile:
        mobile = value;

      case ContactProperties.email:
        email = value;

      case ContactProperties.address:
        address = value;

      case ContactProperties.company:
        company = value;

      case ContactProperties.designation:
        designation = value;

      case ContactProperties.website:
        website = value;
    }
  }

  void createContact() {
    final contact = ContactModel(
      name: name, 
      mobile: mobile,
      email: email,
      address: address,
      company: company,
      designation: designation,
      website: website,
      image: image
      );

      context.goNamed(FormPage.routeName, extra: contact);

  }
}
