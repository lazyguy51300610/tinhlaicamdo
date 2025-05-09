import 'dart:math';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'result_page.dart';

const primaryColor = Color.fromARGB(255, 18, 180, 82);


class CalculatingPage extends StatefulWidget {
  const CalculatingPage({super.key});

  @override
  State<CalculatingPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CalculatingPage> {
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _dateFromController = TextEditingController();
  final TextEditingController _dateToController = TextEditingController();

  final numberFormater = NumberFormat("#,##0", "en_US");

  final _formKey = GlobalKey<FormState>();

  DateTime? _dateFrom;
  DateTime _dateTo = DateTime.now();
  int _amount = 0;
  int _interestRate = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính Lãi', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: 500,
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
                TextFormField(
                  controller: _amountController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.money),
                    labelText: "Số tiền",
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: _onAmountChanged,
                  validator: _onValidated,
                ),
                TextFormField(
                  controller: _dateFromController,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  onTap:
                      () => _onDateSelected(
                        context,
                        _dateFromController,
                      ).then((value) => _dateFrom = value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Ngày cầm đồ",
                  ),
                  validator: _onValidated,
                ),
                TextFormField(
                  controller: _dateToController,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  onTap:
                      () => _onDateSelected(
                        context,
                        _dateToController,
                      ).then((result) => _dateTo = result!),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Ngày chuột đồ",
                  ),
                  validator: _onValidated,
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(primaryColor),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.fromLTRB(40, 20, 40, 20),
                    ),
                  ),
                  onPressed: _onCalculatePressed,
                  child: Text(
                    'Tính Lãi',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _onValidated(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập vào";
    }
    return null;
  }

  void _onAmountChanged(String value) {
    _amount = int.parse(value.replaceAll(",", ""));
    _amountController.text = numberFormater.format(_amount);
    _amountController.selection = TextSelection(
      baseOffset: _amountController.value.text.length,
      extentOffset: _amountController.value.text.length,
    );
  }

  void _onCalculatePressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var dateFrom = _formatDate(_dateFrom!);
    var dateTo = _formatDate(_dateTo);
    var nDate = _dateTo.difference(_dateFrom!).inDays;
    var interest = _amount * _interestRate * 0.01 / 30 * nDate;
    interest = (interest * 1e-3).roundToDouble() * 1e3;
    interest = max(interest, 10000);
    var total = _amount + interest;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResultPage(
              myData: Data(
                dateFrom,
                dateTo,
                nDate.toString(),
                _interestRate.toString(),
                numberFormater.format(_amount),
                numberFormater.format(interest),
                numberFormater.format(total),
              ),
            ),
      ),
    );
  }

  Future<DateTime?> _onDateSelected(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final picked = await showDatePickerDialog(
      context: context,
      initialDate: DateTime.now(),
      minDate: DateTime(1900),
      maxDate: DateTime(2100),
      width: 500,
      height: 500,
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
