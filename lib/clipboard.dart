import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: constant_identifier_names
const FONT_SIZE = 20.0;

const QR_LINK =
    "https://img.vietqr.io/image/KIENLONGBANK-TVHUYNH-qr_only.png?amount={amount}&addInfo=CK&accountName=NGUYEN%20VAN%20DUY";

const FORMULA =
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

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        color: Colors.blueAccent[200],
        child: Container(
          alignment: Alignment.center,
          color: Colors.green[200],
          width: 500,
          margin: EdgeInsets.symmetric(vertical: 50),
          child: Container(
            // margin: EdgeInsets.fromLTRB(100, 0, 100, 50),
            color: Colors.amberAccent[100],
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.redAccent[100],
                      margin: EdgeInsets.only(left: 50),
                      width: 200,
                      child: const Text(
                        "Ngày cầm đồ",
                        style: TextStyle(
                          fontSize: FONT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blueAccent[100],
                      margin: EdgeInsets.only(right: 50),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "12/01/2025",
                        style: TextStyle(fontSize: FONT_SIZE),
                      ),
                    ),
                  ],
                ),
                // ListView(
                //   shrinkWrap: false,
                //   scrollDirection: Axis.horizontal,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Ngày cầm đồ",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "12/01/2025",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //   ],
                // ),
                // GridView.count(
                //   primary: false,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   crossAxisCount: 2,
                //   mainAxisSpacing: 10,
                //   crossAxisSpacing: 10,
                //   childAspectRatio: 1 / .1,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Ngày cầm đồ",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "12/01/2025",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Ngày chuột đồ",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "12/04/2025",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Số ngày chịu lãi",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "25",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Lãi suất",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "4%",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Số tiền",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         "1,000,000",
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Lãi",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         '267,000',
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left: 50),
                //       alignment: Alignment.centerLeft,
                //       child: const Text(
                //         "Tổng cộng",
                //         style: TextStyle(
                //           fontSize: FONT_SIZE,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 50),
                //       alignment: Alignment.centerRight,
                //       child: const Text(
                //         '1,267,000',
                //         style: TextStyle(fontSize: FONT_SIZE),
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  margin: EdgeInsets.all(70),
                  child: Center(
                    child: const Image(
                      image: NetworkImage(QR_LINK),
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
