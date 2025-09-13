import 'package:cardholder/db/db_helper.dart';
import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final _db = DbHelper();

  Future<int> insertContact(ContactModel contactModel) async {
    final rowId = await _db.insertContact(contactModel);
    contactModel.id = rowId;
    contactList.add(contactModel);
    notifyListeners();
    return rowId;
  }

  Future<void> getAllContacts() async {
    contactList = await _db.getAllContacts();
    notifyListeners();
  }

  Future<void> deleteContact(int id) {
    return _db.deleteContact(id);
  }
}
