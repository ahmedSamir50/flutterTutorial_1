// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/models/todo_model.dart';
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
            content: Text("DB Is Opened "),
          ))
    })
     .then((value) => {
       ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
         content: Text("CreateDb Calling Done "),
       ))
     }
     );
  }

  static Future<int?> InsertNewTask(String title ,String dt , String time)async {
    DateTime dateOF = DateFormat("dd/MM/yyyy hh:mm").parse(dt+" "+time);
    Database db = await openDatabase(_dbPath,version: _dbVersion);
    int insertedId = 0;
    await db.transaction((trans)async{
       insertedId = await trans.rawInsert('''
           insert into tasks ('title' , 'timeOfCreation' , 'state' , 'LastStateTime')
                        values ('$title',
                                '$dateOF',
                                '${TODOAPPTASKStatuses.CREATED}' ,
                                datetime('now') )
       ''');
    });
    return insertedId;
  }

  static Future<List<TODOModel>> GetAllTodos()async{
    Database db = await openDatabase(_dbPath,version: _dbVersion);
    List<Map> dbList = await db.rawQuery('SELECT * FROM tasks order by date(timeOfCreation) DESC');
    List<TODOModel> modelList =  dbList.map((e) => TODOModel.fromMap(e))
                                       .toList();
    return modelList;
  }
}
