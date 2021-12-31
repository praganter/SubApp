import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:subapp/db_functions.dart';
import 'package:subapp/model/list_model.dart';

class HomePageProvider extends ChangeNotifier {
  DbFunctions dbFunctions = DbFunctions();
  Box? modelBox;
  List<ListModel> list = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController totalInstallmentInController = TextEditingController();
  TextEditingController currentInstallmentController = TextEditingController();
  TextEditingController payDayController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var key;

  getStartingData() async {
    await dbFunctions.openBox();
    list = Hive.box<ListModel>('list').values.toList().cast<ListModel>();
    await dbFunctions.closeBox();
    notifyListeners();
  }

  clearFields() {
    nameController.clear();
    totalInstallmentInController.clear();
    currentInstallmentController.clear();
    payDayController.clear();
    amountController.clear();
    notifyListeners();
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

  addRecord() async {
    await dbFunctions.addRecord(
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
    await getStartingData();
    notifyListeners();
  }

  deleteRecord(ListModel model) async {
    await dbFunctions.deleteRecord(model.key);
    await getStartingData();
  }

  updateStatus(ListModel model) async {
    if (model.status == false) {
      await deleteRecord(model);
      await dbFunctions.addRecord(ListModel(
          name: model.name,
          payDay: model.payDay,
          amount: model.amount,
          totalInstallment: model.totalInstallment,
          currentInstallment: model.currentInstallment + 1,
          status: true));
      await getStartingData();
    }
  }

  updateRecord(ListModel model) async {
    nameController.text = model.name;
    totalInstallmentInController.text = model.totalInstallment.toString();
    currentInstallmentController.text = model.currentInstallment.toString();
    payDayController.text = model.payDay.toString();
    amountController.text = model.amount.toString();
    await deleteRecord(model);
  }

  double getMonthlyPaid() {
    double amount = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i].status == true) {
        amount += list[i].amount;
      }
    }
    return amount;
  }

  double getMonthlyWillPaid() {
    double amount = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i].status == false) {
        amount += list[i].amount;
      }
    }
    return amount;
  }

  double getTotalPaid() {
    double amount = 0;
    for (var i = 0; i < list.length; i++) {
      amount += list[i].amount * list[i].currentInstallment;
    }
    return amount;
  }

  double getTotalWillPaid() {
    double amount = 0;
    for (var i = 0; i < list.length; i++) {
      amount += list[i].amount *
          (list[i].totalInstallment - list[i].currentInstallment);
    }
    return amount;
  }

  monthCheck() async {
    await getStartingData();
    for (var i = 0; i < list.length; i++) {
      await dbFunctions.deleteRecord(list[i].key);
      await dbFunctions.addRecord(ListModel(
          name: list[i].name,
          payDay: list[i].payDay,
          amount: list[i].amount,
          totalInstallment: list[i].totalInstallment,
          currentInstallment: list[i].currentInstallment,
          status: false));

      print("düzeltti");
    }
    await getStartingData();
  }
}
