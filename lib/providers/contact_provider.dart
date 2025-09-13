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

  Future<void> getAllFavoriteContacts() async {
    contactList = await _db.getAllFavoriteContacts();
    notifyListeners();
  }

  Future<void> deleteContact(int id) {
    return _db.deleteContact(id);
  }

  Future<void> updateFavorite(ContactModel contactModel) async {
    //contactModel.favorite = !contactModel.favorite;
    final value = contactModel.favorite ? 0 : 1;
    await _db.updateFavorite(contactModel.id, value);

    final index = contactList.indexOf(contactModel);
    contactList[index].favorite = !contactList[index].favorite;
  }
}
