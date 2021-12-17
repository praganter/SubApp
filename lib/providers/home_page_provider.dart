import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:subapp/model/list_model.dart';

class HomePageProvider extends ChangeNotifier {
  Box? modelBox;
  List<ListModel> list = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController totalInstallmentInController = TextEditingController();
  TextEditingController currentInstallmentController = TextEditingController();
  TextEditingController payDayController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var key;

  getStartingData() async {
    await Hive.openBox<ListModel>('list');
    list = Hive.box<ListModel>('list').values.toList().cast<ListModel>();
    Hive.close();
    notifyListeners();
  }

  clearFields() {
    nameController.clear();
    totalInstallmentInController.clear();
    currentInstallmentController.clear();
    payDayController.clear();
    amountController.clear();
  }

  checkNewRecordFields() {
    if (nameController.text.isNotEmpty &&
        totalInstallmentInController.text.isNotEmpty &&
        currentInstallmentController.text.isNotEmpty &&
        payDayController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> addNewRecord() async {
    await Hive.openBox<ListModel>('list');
    Hive.box<ListModel>('list').add(
      ListModel(
        name: nameController.text,
        totalInstallment: int.parse(totalInstallmentInController.text),
        currentInstallment: int.parse(currentInstallmentController.text),
        payDay: int.parse(payDayController.text),
        amount: double.parse(amountController.text),
        status: false,
      ),
    );

    clearFields();
    list = Hive.box<ListModel>('list').values.toList().cast<ListModel>();
    Hive.close();
    notifyListeners();
  }

  editExistingRecord() async {
    await Hive.openBox<ListModel>('list');
    Hive.box<ListModel>('list').delete(key);
    addNewRecord();
    //getStartingData();
  }

  deleteListItem(ListModel model) async {
    await Hive.openBox<ListModel>('list');
    Hive.box<ListModel>('list').delete(model.key);
    getStartingData();
  }

  editCurrentItem(ListModel model) async {
    key = model.key;
    nameController.text = model.name;
    totalInstallmentInController.text = model.totalInstallment.toString();
    currentInstallmentController.text = model.currentInstallment.toString();
    payDayController.text = model.payDay.toString();
    amountController.text = model.amount.toString();
  }
}
