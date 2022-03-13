// ignore_for_file: non_constant_identifier_names

import 'package:sqflite/sqflite.dart';

class ToDoAppDbAHandler {
  static const _dbPath = "todoAppSqliteDb.db";

  static void CreateToDoDB()  {
     openDatabase(_dbPath,
        version: 1,
        onCreate: (Database db, int version)  {
              db.execute('''
             CREATE TABLE Tasks
              (id INTEGER PRIMARY KEY, title TEXT, 
              timeOfCreation TEXT, LastStateTime TEXT ,
              state INTEGER)
              ''')
              .then((value) => print("DB Created"))
              .catchError((onError) => {print("Error while Creating the Db")});
        },
        onOpen: (db) => {print("DB Is Opend ")})
     .then((value) => print("CreateDb Calling Done"));
  }
}
