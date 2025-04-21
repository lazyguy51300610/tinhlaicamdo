import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'calculating_page.dart';
import 'clipboard.dart';
import 'result_page.dart';

final seed = Data("xx/xx/xxxx", "yy/yy/yyyy", "n", "4", "1,234,567", "45,678", "1,280,245");

void main() => runApp(MaterialApp(home: ResultPage(data: seed)));
// void main() {
//   Share.downloadFallbackEnabled = true;
//   runApp(const DemoApp());
// }
// void main() => runApp(MaterialApp(home: CalculatingPage()));
