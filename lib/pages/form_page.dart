import 'package:cardholder/models/contact_model.dart';
import 'package:cardholder/pages/home_page.dart';
import 'package:cardholder/utils/constants.dart';
import 'package:cardholder/utils/helpers.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;

  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final webController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactModel.name),
        actions: [IconButton(onPressed: saveContact, icon: Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Contact name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              decoration: InputDecoration(labelText: 'Street address'),
              validator: (value) {
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Company name'),
              validator: (value) {
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              controller: designationController,
              decoration: InputDecoration(labelText: 'Designation'),
              validator: (value) {
                return null; // return null; → «ошибок нет».
              },
            ),

            TextFormField(
              controller: webController,
              decoration: InputDecoration(labelText: 'Website'),
              validator: (value) {
                return null; // return null; → «ошибок нет».
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    emailController.text = widget.contactModel.email;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    webController.text = widget.contactModel.website;
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    designationController.dispose();
    webController.dispose();
    super.dispose();
  }

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.website = webController.text;
    }

    Provider.of<ContactProvider>(context, listen: false)
    .insertContact(widget.contactModel)
    .then((value) {
      if (value > 0) {
        showMsg(context, 'Saved');
        context.goNamed(HomePage.routeName);
      }
    })
    .catchError((error) {
      showMsg(context, 'Failed to save');
    })
    ;
    
  }
}
