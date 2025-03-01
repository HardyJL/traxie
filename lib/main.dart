import 'package:flutter/widgets.dart';
import 'package:traxie/app.dart';
import 'package:traxie/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
