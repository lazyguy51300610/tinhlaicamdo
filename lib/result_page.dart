import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:share_plus/share_plus.dart';

import 'custom_button.dart';

const MARGIN_VERTICAL = 2.0;
const COLUMN_1_WIDTH = 200.0;
const COLUMN_2_WIDTH = 200.0;
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
const account0 = "TVHUYNH";
const account1 = "TVHUYNH1";
const TEMPLATE_DEFAULT = "qr_only";
const TEMPLATE_FULL = "print";
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
  State<StatefulWidget> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  _ResultPageState();

  final _imageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Kết quả', style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      actions: [
        IconButton(onPressed: _onShareButtonClicked, icon: Icon(Icons.share), color: Colors.white),
      ],
    ),
    body: WidgetsToImage(controller: _imageController, child: _billCard(context)),
  );

  Widget _billCard(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
    child: Column(
      children: [
        KeyValueLine(keyText: "Ngày cầm đồ", valueText: widget.myData.dateFrom),
        KeyValueLine(keyText: "Ngày chuột đồ", valueText: widget.myData.dateTo),
        KeyValueLine(keyText: "Số ngày chịu lãi", valueText: widget.myData.nDate),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        KeyValueLine(keyText: "Lãi suất", valueText: widget.myData.interestRate),
        KeyValueLine(keyText: "Số tiền", valueText: widget.myData.amount),
        KeyValueLine(keyText: "Lãi", valueText: widget.myData.interest),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        KeyValueLine(keyText: "Tổng cộng", valueText: widget.myData.total),

        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: (context) => _showModalBottomSheet(widget.myData.interest),
                text: "Đóng lãi",
              ),
              CustomButton(
                onPressed: (context) => _showModalBottomSheet(widget.myData.total),
                text: "Chuột đồ",
              ),
            ],
          ),
        ),
      ],
    ),
  );

  void _onShareButtonClicked() async {
    final imageUrl = _getQRLink(account0, "1000000", TEMPLATE_FULL);
    final url = Uri.parse(imageUrl);
    final result = await Share.shareUri(url);
    if (result.status == ShareResultStatus.success) {
      print("result.status == ShareResultStatus.success");
    } else if (result.status == ShareResultStatus.dismissed) {
      print("result.status == ShareResultStatus.dismissed");
    } else if (result.status == ShareResultStatus.unavailable) {
      print("result.status == ShareResultStatus.unavailable");
    }
  }

  void _showModalBottomSheet(String amount) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder:
        (context) => FractionallySizedBox(
          heightFactor: 0.7,
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const TabBar(tabs: [Tab(text: "Nhà"), Tab(text: "Quầy")]),
              ),
              body: TabBarView(
                children: [
                  ListView(
                    children: [
                      _transferQR(account0, amount.replaceAll(",", "")),
                      _transferInfo(account0, amount),
                    ],
                  ),
                  ListView(
                    children: [
                      _transferQR(account1, amount.replaceAll(",", "")),
                      _transferInfo(account1, amount),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
  );

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
    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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

  String _getQRLink(String accountNumber, String amount, [String? template]) {
    var qrlink = formulaQRLink
        .replaceAll(FORMULA_BANK_ID, BANK_ID)
        .replaceAll(FORMULA_ACCOUNT_NO, accountNumber)
        .replaceAll(FORMULA_TEMPLATE, template ?? TEMPLATE_DEFAULT)
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
