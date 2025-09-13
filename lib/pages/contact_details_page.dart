import 'package:cardholder/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:cardholder/models/contact_model.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = 'details';
  final int id;

  const ContactDetailsPage({super.key, required this.id});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late int id;

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),

      body: Consumer<ContactProvider>(
        builder: (ctx, provider, child) => FutureBuilder<ContactModel>(
          future: provider.getContactById(id),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final contact = snapshot.data;
              return ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  Image.file(
                    File(contact!.image),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(contact.mobile),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _callContact(contact.mobile);
                          },
                          icon: const Icon(Icons.call),
                        ),

                        IconButton(
                          onPressed: () {
                            _smsContact(contact.mobile);
                          },
                          icon: const Icon(Icons.sms),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Failed to load data'));
            }

            return const Center(child: Text('Please wait...'));
          },
        ),
      ),
    );
  }

  //  url_launcher:
  void _callContact(String mobile) async {
    final url = 'tel:$mobile';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Cannot perform this task');
    }
  }

  //  url_launcher:
  void _smsContact(String mobile) async {
    final url = 'sms:$mobile';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Cannot perform this task');
    }
  }
}
