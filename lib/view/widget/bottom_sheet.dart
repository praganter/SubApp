import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subapp/providers/home_page_provider.dart';
import 'new_record_row.dart';

Future<dynamic> bottomSheet(BuildContext context, bool isUpdate) {
  return showModalBottomSheet(
    //backgroundColor: Colors.blue,
    barrierColor: Colors.black.withOpacity(0.5),
    enableDrag: false,
    isDismissible: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    ),
    elevation: 20.0,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          //!Başlık Kısmı
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: const [
                            Center(
                              child: Text(
                                'Yeni Kayıt',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //!Alanlar
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      newRecordRow(
                        hintText: "X bankası kredisi",
                        titleText: "İsmi :",
                        textController:
                            Provider.of<HomePageProvider>(context, listen: true)
                                .nameController,
                        isInt: false,
                      ),
                      newRecordRow(
                        hintText: "2000",
                        titleText: "Tutar :",
                        textController:
                            Provider.of<HomePageProvider>(context, listen: true)
                                .amountController,
                        isInt: true,
                      ),
                      newRecordRow(
                        hintText: "12 - 24 - 36 ay",
                        titleText: "Vade :",
                        textController:
                            Provider.of<HomePageProvider>(context, listen: true)
                                .totalInstallmentInController,
                        isInt: true,
                      ),
                      newRecordRow(
                        hintText: "Ayın 15i",
                        titleText: "Ödeme Günü :",
                        textController:
                            Provider.of<HomePageProvider>(context, listen: true)
                                .payDayController,
                        isInt: true,
                      ),
                      newRecordRow(
                        hintText: "5 ay ödedim",
                        titleText: "Ödenenen taksitler :",
                        textController:
                            Provider.of<HomePageProvider>(context, listen: true)
                                .currentInstallmentController,
                        isInt: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //!Kaydet Butonu
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: MaterialButton(
                    disabledColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    color: Colors.red,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    elevation: 0,
                    onPressed:
                        (Provider.of<HomePageProvider>(context, listen: true)
                                    .checkNewRecordFields() &&
                                !isUpdate)
                            ? () {
                                Provider.of<HomePageProvider>(context,
                                        listen: false)
                                    .addNewRecord();
                                Navigator.pop(context);
                              }
                            : () {
                                Provider.of<HomePageProvider>(context,
                                        listen: false)
                                    .editExistingRecord();
                                Navigator.pop(context);
                              },
                    child: Text("KAYDET"),
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
