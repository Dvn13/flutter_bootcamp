import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static const String databaseName = "tododatabase.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(databasePath)) {
      print("Info: Veritabanı daha önce kopyalanmıştır.");
    } else {
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      print("Info: Veritabanı kopyalandı");
    }
    return openDatabase(databasePath);
  }
}
