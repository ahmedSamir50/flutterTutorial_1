// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/shared/components/constants.dart';

class ToDoAppDbAHandler {
  static const _dbPath = "todoAppSqliteDb.db";
  static const _dbVersion = 1;
  static void CreateToDoDB(BuildContext ctx)  {
     openDatabase(_dbPath,
        version: _dbVersion,
        onCreate: (Database db, int version)  {
              db.execute('''
             CREATE TABLE Tasks
              (id INTEGER PRIMARY KEY, title TEXT, 
              timeOfCreation TEXT, LastStateTime TEXT ,
              state INTEGER)
              ''')
              .then((value) => {
                ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                  content: Text("SDB Created"),
                ))
              })
              .catchError((onError) => {
                ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                  content: Text("Error while Creating the Db"),
                ))
              });
        },
        onOpen: (db) => {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text("DB Is Opend "),
          ))
    })
     .then((value) => {
       ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
         content: Text("CreateDb Calling Done "),
       ))
     }
     );
  }

  static Future<int?> InsertNewTask(String title )async {
    Database db = await openDatabase(_dbPath,version: _dbVersion);
    db.transaction((trans)async{
      int insertedId = await trans.rawInsert('''
           insert into tasks (title , timeOfCreation , state , LastStateTime)
                        values ($title,
                                datetime('now'),
                                ${TODOAPPTASKStatuses.CREATED} ,
                                datetime('now') )
       ''');
      return insertedId;
    });
    return null;
  }
}
