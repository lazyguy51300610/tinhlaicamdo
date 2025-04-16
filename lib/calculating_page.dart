import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'result_page.dart';

const primaryColor = Color.fromARGB(255, 18, 180, 82);

class CalculatingPage extends StatelessWidget {
  const CalculatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MyHomePage(title: 'Tính lãi Cầm Đồ');
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({required this.title});

  final String title;

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _dateFromController = TextEditingController();
  final TextEditingController _dateToController = TextEditingController();

  final numberFormater = NumberFormat("#,##0", "en_US");

  DateTime? _dateFrom;
  DateTime _dateTo = DateTime.now();
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính Lãi', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(50.0),
          children: <Widget>[
            SizedBox(
              height: 70,
              child: TextField(
                controller: _amountController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                  labelText: "Số tiền",
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  
                  _amount = int.parse(value.replaceAll(",", ""));
                  _amountController.text = numberFormater.format(_amount);
                  _amountController.selection = TextSelection(baseOffset: _amountController.value.text.length, extentOffset: _amountController.value.text.length);
                },
                
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _dateFromController,
                textAlign: TextAlign.right,
                readOnly: true,
                onTap:
                    () => _selectDate(
                      _dateFromController,
                    ).then((result) => _dateFrom = result),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: "Ngày cầm đồ",
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _dateToController,
                textAlign: TextAlign.right,
                readOnly: true,
                onTap:
                    () => _selectDate(
                      _dateToController,
                    ).then((result) => _dateTo = result!),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: "Ngày chuột đồ",
                ),
              ),
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primaryColor),
                padding: WidgetStateProperty.all(EdgeInsets.all(20)),
              ),
              onPressed: _calculate,
              child: Text(
                'Tính Lãi',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() {
    var dateFrom = _formatDate(_dateFrom!);
    var dateTo = _formatDate(_dateTo);
    var nDate = _dateTo.difference(_dateFrom!).inDays.toString();
    var interestRate = "4%";
    var amount = _amountController.text;
    var interest = "267,000";
    var total = "1,267,000";

    log("dateFrom = $dateFrom");
    log("dateTo = $dateTo");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResultPage(
              data: Data(
                dateFrom,
                dateTo,
                nDate,
                interestRate,
                amount,
                interest,
                total,
              ),
            ),
      ),
    );
  }

  Future<DateTime?> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        final formatedDate = _formatDate(picked);
        controller.text = formatedDate;
      });
    }

    return picked;
  }

  String _formatDate(DateTime dateTime) {
    // yyyy-MM-dd
    final date = dateTime.toString().split(" ")[0].split("-");
    // dd/MM/yyyy
    final formatedDate = "${date[2]}/${date[1]}/${date[0]}";
    return formatedDate;
  }
}
