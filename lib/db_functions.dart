import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'model/list_model.dart';

class DbFunctions {
  openBox() async {
    await Hive.openBox<ListModel>('list');
  }

  closeBox() async {
    await Hive.close();
  }

  addRecord(ListModel model) async {
    await openBox();
    await Hive.box<ListModel>('list').add(model);
    await closeBox();
  }

  updateRecord(ListModel model, dynamic key) async {
    await deleteRecord(key);
    await addRecord(model);
  }

  deleteRecord(dynamic key) async {
    await openBox();
    await Hive.box<ListModel>('list').delete(key);
    await closeBox();
  }
}
