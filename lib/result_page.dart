import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

const MARGIN_VERTICAL = 2.0;
const COLUMN_1_WIDTH = 150.0;
const COLUMN_2_WIDTH = 150.0;
const COLUMNS_WIDTH = COLUMN_1_WIDTH + COLUMN_2_WIDTH;

const cellWidth = 550;
const cellHeight = 100;

const primaryColor = Color.fromARGB(255, 18, 180, 82);

const primaryFontSize = 20.0;

const formulaQRLink =
    "https://img.vietqr.io/image/<BANK_ID>-<ACCOUNT_NO>-<TEMPLATE>.png?amount=<AMOUNT>&addInfo=<DESCRIPTION>&accountName=<ACCOUNT_NAME>";

const FORMULA_BANK_ID = "<BANK_ID>";
const FORMULA_ACCOUNT_NO = "<ACCOUNT_NO>";
const FORMULA_TEMPLATE = "<TEMPLATE>";
const FORMULA_AMOUNT = "<AMOUNT>";
const FORMULA_DESCRIPTION = "<DESCRIPTION>";
const FORMULA_ACCOUNT_NAME = "<ACCOUNT_NAME>";

const BANK_ID = "KIENLONGBANK";
const ACCOUNT_NO = "TVHUYNH";
const ACCOUNT_NO_1 = "TVHUYNH1";
const TEMPLATE = "qr_only";
//const AMOUNT = "<AMOUNT>";
const DESCRIPTION = "CK";
const ACCOUNT_NAME = "NGUYEN%20VAN%20DUY";

class Data {
  final String dateFrom;
  final String dateTo;
  final String nDate;
  final String interestRate;
  final String amount;
  final String interest;
  final String total;

  Data(
    this.dateFrom,
    this.dateTo,
    this.nDate,
    this.interestRate,
    this.amount,
    this.interest,
    this.total,
  );
}

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.myData});

  final Data myData;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => ResultPageState(data: myData);
}

class ResultPageState extends State<ResultPage> {
  ResultPageState({required this.data});

  final Data data;

  final WidgetsToImageController _imageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Kết quả', style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share), color: Colors.white)],
    ),
    body: WidgetsToImage(controller: _imageController, child: _billCard(context)),
  );

  Widget _billCard(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
    child: Column(
      children: [
        KeyValueLine(keyText: "Ngày cầm đồ", valueText: data.dateFrom),
        KeyValueLine(keyText: "Ngày chuột đồ", valueText: data.dateTo),
        KeyValueLine(keyText: "Số ngày chịu lãi", valueText: data.nDate),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        KeyValueLine(keyText: "Lãi suất", valueText: data.interestRate),
        KeyValueLine(keyText: "Số tiền", valueText: data.amount),
        KeyValueLine(keyText: "Lãi", valueText: data.interest),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        KeyValueLine(keyText: "Tổng cộng", valueText: data.total),

        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResultPageButton(onPressed: _showInterestQR, text: "Đóng lãi"),
              ResultPageButton(onPressed: _showTotalQR, text: "Chuột đồ"),
            ],
          ),
        ),
      ],
    ),
  );

  void _showTotalQR(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(title: const TabBar(tabs: [Tab(text: "Nha"), Tab(text: "Quay")])),
              body: TabBarView(
                children: [
                  ListView(
                    children: [
                      _transferQR(ACCOUNT_NO, data.total.replaceAll(",", "")),
                      _transferInfo(ACCOUNT_NO, data.total),
                    ],
                  ),

                  ListView(
                    children: [
                      _transferQR(ACCOUNT_NO_1, data.total.replaceAll(",", "")),
                      _transferInfo(ACCOUNT_NO_1, data.total),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showInterestQR(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const TabBar(tabs: [Tab(text: "Nha"), Tab(text: "Quay")]),
              ),
              body: TabBarView(
                children: [
                  ListView(
                    children: [
                      _transferQR(ACCOUNT_NO, data.interest.replaceAll(",", "")),
                      _transferInfo(ACCOUNT_NO, data.interest),
                    ],
                  ),

                  ListView(
                    children: [
                      _transferQR(ACCOUNT_NO_1, data.interest.replaceAll(",", "")),
                      _transferInfo(ACCOUNT_NO_1, data.interest),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _transferQR(String accountNumberValue, String amountValue) => Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Center(
      child: Image(
        image: NetworkImage(_getQRLink(accountNumberValue, amountValue)),
        height: 150,
        fit: BoxFit.fill,
      ),
    ),
  );

  Widget _transferInfo(String accountNumberValue, String amountValue) => Container(
    margin: EdgeInsets.symmetric(horizontal: 100),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      childAspectRatio: cellWidth / cellHeight,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Ngân hàng:",
            style: TextStyle(fontSize: primaryFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        Container(alignment: Alignment.centerRight, child: Text(BANK_ID)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "STK:",
            style: TextStyle(fontSize: primaryFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        Container(alignment: Alignment.centerRight, child: Text(accountNumberValue)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Chủ TK:",
            style: TextStyle(fontSize: primaryFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(ACCOUNT_NAME.replaceAll("%20", " ")),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Số tiền:",
            style: TextStyle(fontSize: primaryFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        Container(alignment: Alignment.centerRight, child: Text(amountValue)),
      ],
    ),
  );

  String _getQRLink(String accountNumber, String amount) {
    var qrlink = formulaQRLink
        .replaceAll(FORMULA_BANK_ID, BANK_ID)
        .replaceAll(FORMULA_ACCOUNT_NO, accountNumber)
        .replaceAll(FORMULA_TEMPLATE, TEMPLATE)
        .replaceAll(FORMULA_AMOUNT, amount)
        .replaceAll(FORMULA_DESCRIPTION, DESCRIPTION)
        .replaceAll(FORMULA_ACCOUNT_NAME, ACCOUNT_NAME);
    return qrlink;
  }
}

class KeyValueLine extends StatelessWidget {
  final String keyText;
  final String valueText;

  const KeyValueLine({super.key, required this.keyText, required this.valueText});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [getKeyCell(keyText), getValueCell(valueText)],
    ),
  );

  Widget getKeyCell(final String value) => Container(
    alignment: Alignment.centerLeft,
    width: COLUMN_1_WIDTH,
    child: Text(value, style: TextStyle(fontSize: primaryFontSize, fontWeight: FontWeight.bold)),
  );

  Widget getValueCell(final String value) => Container(
    alignment: Alignment.centerRight,
    width: COLUMN_2_WIDTH,
    child: Text(value, style: TextStyle(fontSize: primaryFontSize)),
  );
}

class ResultPageButton extends StatelessWidget {
  final Function(BuildContext) onPressed;
  final String text;

  const ResultPageButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(primaryColor),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
      ),
      onPressed: () => onPressed(context),
      child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
    ),
  );
}
