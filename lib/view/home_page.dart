import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subapp/model/list_model.dart';
import 'package:subapp/providers/home_page_provider.dart';
import 'package:subapp/view/widget/bottom_sheet.dart';

import 'widget/list_row.dart';
import 'widget/summary_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListModel> model =
        Provider.of<HomePageProvider>(context, listen: true).list;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HARCAMALAR',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () => null,
        ),
        actions: [
          IconButton(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => bottomSheet(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: (model.isEmpty)
          ? null
          : ListView.builder(
              itemBuilder: (context, i) {
                return ListRow(
                  model: model[i],
                );
              },
              itemCount: model.length),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SummaryRow(
              title: "Aylık Ödenen",
              amount: Provider.of<HomePageProvider>(context, listen: false)
                  .getMonthlyPaid(),
            ),
            SummaryRow(
              title: "Aylık Ödenecek",
              amount: Provider.of<HomePageProvider>(context, listen: false)
                  .getMonthlyWillPaid(),
            ),
            SummaryRow(
              title: "Toplam Ödenen",
              amount: Provider.of<HomePageProvider>(context, listen: false)
                  .getTotalPaid(),
            ),
            SummaryRow(
              title: "Toplam Ödenecek",
              amount: Provider.of<HomePageProvider>(context, listen: false)
                  .getTotalWillPaid(),
            )
          ],
        ),
      ),
    );
  }
}
