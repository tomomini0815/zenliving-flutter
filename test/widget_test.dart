import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenliving/main.dart';

void main() {
  testWidgets('ZenLiving smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ZenLivingApp());
    expect(find.text('ZenLiving'), findsWidgets);
  });
}
