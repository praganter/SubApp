import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subapp/providers/home_page_provider.dart';
import 'package:subapp/view/widget/bottom_sheet.dart';

import 'widget/list_row.dart';
import 'widget/summary_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: (Provider.of<HomePageProvider>(context, listen: false).list.isEmpty)
          ? null
          : ListView.builder(
              itemBuilder: (context, i) {
                return ListRow(
                  index: i,
                );
              },
              itemCount: Provider.of<HomePageProvider>(context, listen: true)
                  .getList()
                  .length),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SummaryRow(
              title: "Ayın Toplam Ödemesi",
              amount: 0,
            ),
            SummaryRow(
              title: "Tüm Borçlar ",
              amount: 0,
            ),
            SummaryRow(
              title: "Tüm Ödenenler ",
              amount: 0,
            )
          ],
        ),
      ),
    );
  }
}
