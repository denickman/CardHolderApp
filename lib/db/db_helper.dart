import 'package:cardholder/models/contact_model.dart';
import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final String _createTableContact =
      '''create table $tableContact(
    $tblContactId integer primary key autoincrement,
    $tblContactName text,
    $tblContactMobile text,
    $tblContactEmail text,
    $tblContactAddress text,
    $tblContactCompany text,
    $tblContactDesignation text,
    $tblContactWebsite text,
    $tblContactImage text,
    $tblContactFavorite integer)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, 'contact.db');
    return openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if(oldVersion == 1) {
          await db.execute('alter table $tableContact rename to ${'contact_old'}');
          await db.execute(_createTableContact);

          final rows = await db.query('contact_old');
          for (var row in rows) {
            await db.insert(tableContact, row);
          }

          await db.execute('drop table if exists ${'contact_old'}');

        }
      }
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<List<ContactModel>> getAllFavoriteContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$tblContactFavorite = ?', whereArgs: [1]);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }



  Future<int> deleteContact(int id) async {
    final db = await _open();
    // return db.delete(tableContact, where: '$tblContactId = ? and $tblContactFavorite = ?', whereArgs: [id, false]);
    return db.delete(tableContact, where: '$tblContactId = ?', whereArgs: [id]);
  }

  Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return db.update(tableContact, {
      tblContactFavorite : value,
    }, where: '$tblContactId = ?', whereArgs: [id]);
  }




}
