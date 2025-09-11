
import 'package:flutter/material.dart'; 


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

                },
                icon: const Icon(Icons.camera),
                label: const Text('Capture')
              ),

              TextButton.icon(
                onPressed: () {

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
}