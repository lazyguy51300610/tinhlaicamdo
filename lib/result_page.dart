import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

const MARGIN_VERTICAL = 2.0;
const COLUMN_1_WIDTH = 200.0;
const COLUMN_2_WIDTH = 300.0;
const COLUMNS_WIDTH = COLUMN_1_WIDTH + COLUMN_2_WIDTH;

const primaryColor = Color.fromARGB(255, 18, 180, 82);

// ignore: constant_identifier_names
const FONT_SIZE = 15.0;

const QR_LINK =
    "https://img.vietqr.io/image/KIENLONGBANK-TVHUYNH-qr_only.png?amount={amount}&addInfo=CK&accountName=NGUYEN%20VAN%20DUY";

const FORMULA_QR_LINK =
    "https://img.vietqr.io/image/<BANK_ID>-<ACCOUNT_NO>-<TEMPLATE>.png?amount=<AMOUNT>&addInfo=<DESCRIPTION>&accountName=<ACCOUNT_NAME>";

const FORMULA_BANK_ID = "<BANK_ID>";
const FORMULA_ACCOUNT_NO = "<ACCOUNT_NO>";
const FORMULA_TEMPLATE = "<TEMPLATE>";
const FORMULA_AMOUNT = "<AMOUNT>";
const FORMULA_DESCRIPTION = "<DESCRIPTION>";
const FORMULA_ACCOUNT_NAME = "<ACCOUNT_NAME>";

const BANK_ID = "KIENLONGBANK";
const ACCOUNT_NO = "TVHUYNH";
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
  ResultPage({super.key, required this.data});

  final Data data;

  @override
  State<StatefulWidget> createState() => ResultPageState(data: data);
}

class ResultPageState extends State<ResultPage> {
  ResultPageState({required this.data});

  final Data data;
  final WidgetsToImageController _imageController = WidgetsToImageController();

  Uint8List? _bytes;

  Widget myRowTemplate(String valueCell1, String valueCell2) => Container(
    margin: EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [myCell1(valueCell1), myCell2(valueCell2)],
    ),
  );

  Widget myCell1(final String value) => Container(
    // color: Colors.amberAccent,
    margin: EdgeInsets.only(left: 50),
    alignment: Alignment.centerLeft,
    width: 150,
    child: Text(
      value,
      style: TextStyle(fontSize: FONT_SIZE, fontWeight: FontWeight.bold),
    ),
  );

  Widget myCell2(final String value) => Container(
    // color: Colors.blueAccent,
    margin: EdgeInsets.only(right: 50),
    alignment: Alignment.centerRight,
    width: 200,
    child: Text(value, style: TextStyle(fontSize: FONT_SIZE)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
        backgroundColor: primaryColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: WidgetsToImage(controller: _imageController, child: _billCard()),
    );
  }

  Widget _buildImage(Uint8List bytes) => Image.memory(bytes);

  Widget _billCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
    child: Column(
      children: [
        myRowTemplate("Ngày cầm đồ", data.dateFrom),
        myRowTemplate("Ngày chuột đồ", data.dateTo),
        myRowTemplate("Số ngày chịu lãi", data.nDate),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        myRowTemplate("Lãi suất", data.interestRate),
        myRowTemplate("Số tiền", data.amount),
        myRowTemplate("Lãi", data.interest),

        Container(
          height: 1,
          width: COLUMNS_WIDTH,
          margin: EdgeInsets.all(MARGIN_VERTICAL),
          color: Colors.black,
        ),

        myRowTemplate("Tổng cộng", data.total),

        Container(
          margin: EdgeInsets.only(top: 70),
          child: Center(
            child: Image(
              image: NetworkImage(_getQRLink()),
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );

  void _onShareAction() async {
    final bytes = await _imageController.capture();
    setState(() {
      _bytes = bytes;
    });

    if (bytes == null) {
      return;
    }

    final imageFile = XFile.fromData(bytes!);
    final result = await Share.shareXFiles([imageFile]);
    ScaffoldMessenger.of(context).showSnackBar(_getResultSnackBar(result));
  }

  SnackBar _getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}"),
        ],
      ),
    );
  }

  String _getQRLink() => FORMULA_QR_LINK
      .replaceAll(FORMULA_BANK_ID, BANK_ID)
      .replaceAll(FORMULA_ACCOUNT_NO, ACCOUNT_NO)
      .replaceAll(FORMULA_TEMPLATE, TEMPLATE)
      .replaceAll(FORMULA_ACCOUNT_NO, ACCOUNT_NO)
      .replaceAll(FORMULA_AMOUNT, data.total.replaceAll(",", ""))
      .replaceAll(FORMULA_DESCRIPTION, DESCRIPTION)
      .replaceAll(FORMULA_ACCOUNT_NAME, ACCOUNT_NAME);
}
