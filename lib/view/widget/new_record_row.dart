import 'package:flutter/material.dart';

class newRecordRow extends StatelessWidget {
  newRecordRow({
    required this.hintText,
    required this.titleText,
    required this.textController,
    required this.isInt,
    Key? key,
  }) : super(key: key);

  String hintText = "";
  String titleText = "";
  TextEditingController textController = TextEditingController();
  bool isInt = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text(titleText)),
              Expanded(
                child: TextField(
                  enableSuggestions: false,
                  keyboardType: isInt
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    //contentPadding: const EdgeInsets.all(10),
                    hintText: hintText,
                    hintMaxLines: 1,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                  //autofocus: true,
                  controller: textController,
                  //cursorHeight: 5,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 3,
          )
        ],
      ),
    );
  }
}
