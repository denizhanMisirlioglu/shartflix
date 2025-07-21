import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shartflix/main.dart';

void main() {
  testWidgets('Uygulama login ekranı ile başlar (token yoksa)', (WidgetTester tester) async {
    // Token olmadığını varsayarak MyApp'e null geçiyoruz
    await tester.pumpWidget(const MyApp(initialToken: null));

    // Örnek olarak: "Giriş Yap" yazısı içeriyor mu?
    expect(find.text('Giriş Yap'), findsOneWidget);
  });
}
