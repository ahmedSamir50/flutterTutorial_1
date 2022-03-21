// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/helpers/helpers.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ToDoAppDbAHandler {
  ToDoAppDbAHandler._privateConstructor();

  static final ToDoAppDbAHandler instance = ToDoAppDbAHandler
      ._privateConstructor();

  static const _dbPath = "todoAppSqliteDb.db";
  static const _dbVersion = 2;
  static Database? _database;

  Future<Database> get database async => _database ??= await _getDbInstance();

  Future<Database> _getDbInstance() async {

    var databasesPath = (await getApplicationDocumentsDirectory()).path;
    var finalPath = join(databasesPath, _dbPath);
    printOnyOnDebugMode(["final path ","$finalPath"]);
    return await openDatabase(finalPath,
        version: _dbVersion,
        onCreate: (db, version) => OnCreateDb(db, version),
        onUpgrade: (db, oldVersion,newVersion) => OnCreateDb(db, newVersion),
        onOpen: (Database db) {
          printOnyOnDebugMode([db.path]);
          printOnyOnDebugMode(["DB Is Opened "]);
        });
  }

  FutureOr<void> OnCreateDb(Database db, int version) async {
    try {
      printOnyOnDebugMode(["Will Create DB "]);
      await db.execute(tasksTableCreationStatement);
      printOnyOnDebugMode(["SDB Created"]);
    }
    catch (onError) {
      printOnyOnDebugMode(["*****Error while Creating the Db***** : ",onError]);
    }
  }

  Future<int?> InsertNewTask(String title, String dt, String time) async {
    DateTime dateOF = DateFormat("dd/MM/yyyy hh:mm").parse(dt + " " + time);
    int insertedId = 0;
    TODOAPPTASKStatuses createdState = TODOAPPTASKStatuses.CREATED;
    String sqlInsertStatement = ''' insert into Tasks ('title' , 'timeOfCreation' , 'state' , 'LastStateTime')
                      values( '$title', '$dateOF' , '$createdState' , datetime('now') ) ''';
    printOnyOnDebugMode([sqlInsertStatement]);
    (await instance.database).transaction((trans) async {
      insertedId = await trans.rawInsert(sqlInsertStatement);
    });
    return insertedId;
  }

  Future<List<TODOModel>> GetAllTodos() async {
    var dbList = await (await instance.database).rawQuery(
        "SELECT * FROM Tasks order by date(timeOfCreation) DESC ");
    List<TODOModel> modelList = (dbList).map((e) =>
        TODOModel.fromMap(e)).toList();
    return modelList;
  }
}
