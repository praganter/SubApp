import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subapp/model/list_model.dart';
import 'package:hive/hive.dart';
import 'package:subapp/providers/home_page_provider.dart';

class ListRow extends StatelessWidget {
  int index = 0;

  ListRow({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListModel> modelList =
        Provider.of<HomePageProvider>(context, listen: false).list
            as List<ListModel>;
    ListModel model = modelList[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(50),
          ),
          color: Colors.red.withOpacity(0.4),
        ),
        height: MediaQuery.of(context).size.height / 10,
        width: MediaQuery.of(context).size.width,
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.cancel_outlined),
                alignment: Alignment.centerLeft,
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("EnPara Kredi"),
                  Text("Ayin 20si"),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("8 / 24 Ay"),
                  const Text("3500" + " TL"),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Text("data"),
                  ),
                  InkWell(
                    child: const Text("data"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
