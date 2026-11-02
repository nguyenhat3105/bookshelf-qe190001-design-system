import 'package:bookshelf/app/theme/app_theme.dart';
import 'package:bookshelf/screens/home_screen.dart';
import 'package:bookshelf/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home and registration remain usable on a 360 px phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(theme: buildAppTheme(), home: const HomeScreen()),
    );
    await tester.ensureVisible(find.text('Rate your favorites'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: const AuthScreen(register: true),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Email is required'), findsNothing);
    final register = find.widgetWithText(FilledButton, 'Register');
    await tester.ensureVisible(register);
    await tester.tap(register);
    await tester.pumpAndSettle();
    expect(find.text('Confirm password is required'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
