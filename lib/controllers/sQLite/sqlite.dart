import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../JsonModels/patients.dart';

class DatabaseMedical {
  final databaseName = "medical.db";
  String doctors =
      "CREATE TABLE doctors (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Now we must create our user table into our sqlite db

  String patients =
      "create table patients (patientID INTEGER PRIMARY KEY AUTOINCREMENT, patientEmail VARCHAR(254) UNIQUE, usrPassword TEXT)";

  //We are done in this section

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(patients);
     // await db.execute(doctors);
    });
  }

  //Now we create login and sign up method
  //as we create sqlite other functionality in our previous video

  //IF you didn't watch my previous videos, check part 1 and part 2

  //Login Method

  Future<bool> login(Patients patient) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from patients where patientEmail = '${patient.patientEmail}' AND usrPassword = '${patient.patientPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Patients patient) async {
    final Database db = await initDB();

    return db.insert('patients', patient.toMap());
  }

 /*
  //Search Method
  Future<List<doctors>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Create Note
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  //Get notes
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Delete Notes
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  //Update Notes
  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
        [title, content, noteId]);
  }
 * */
}