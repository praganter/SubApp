import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subapp/model/list_model.dart';
import 'package:hive/hive.dart';
import 'package:subapp/providers/home_page_provider.dart';
import 'package:subapp/view/widget/bottom_sheet.dart';

class ListRow extends StatelessWidget {
  ListModel model;
  ListRow({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(4, 8), // changes position of shadow
            ),
          ],
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
                  Text(model.name),
                  Text("Ayın ${model.payDay}"),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      "${model.currentInstallment} / ${model.totalInstallment} Ay "),
                  Text(model.amount.toString() + " TL"),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: IconButton(
                      onPressed: () =>
                          Provider.of<HomePageProvider>(context, listen: false)
                              .deleteListItem(model),
                      icon: Icon(Icons.delete_forever),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {
                        Provider.of<HomePageProvider>(context, listen: false)
                            .editCurrentItem(model);
                        bottomSheet(context, true);
                      },
                      icon: Icon(Icons.edit_sharp),
                    ),
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
