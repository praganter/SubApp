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

  Future<void> _openBox() async {
    modelBox = await Hive.openBox<ListModel>('list');
  }

  Future<List<ListModel>> getBox() async {
    _openBox();
    return list = await modelBox!.get('list') as List<ListModel>;
  }

  List<ListModel> getList() {
    getBox();
    print("get liste");
    notifyListeners();
    return list;
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
    await _openBox();
    modelBox!.add(
      ListModel(
        name: nameController.text,
        totalInstallment: int.parse(totalInstallmentInController.text),
        currentInstallment: int.parse(currentInstallmentController.text),
        payDay: int.parse(payDayController.text),
        amount: double.parse(amountController.text),
        status: false,
      ),
    );
    notifyListeners();
    clearFields();
    modelBox!.close();
  }
}
