import 'package:hive/hive.dart';
part 'list_model.g.dart';

@HiveType(typeId: 0)
class ListModel extends HiveObject {
  ListModel({
    required this.name,
    required this.payDay,
    required this.amount,
    required this.totalInstallment,
    required this.currentInstallment,
    this.status = false,
  });
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int payDay;
  @HiveField(2)
  late double amount;
  @HiveField(3)
  late int totalInstallment;
  @HiveField(4)
  late int currentInstallment;
  @HiveField(5)
  late bool status;
}
