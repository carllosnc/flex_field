import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_field/flex_field.dart';

void main() {
  group('FlexField Extension Tests', () {
    testWidgets('should create flex field extension', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final textField = TextFormField(
                  controller: controller,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                );

                return textField.flex(
                  context: context,
                  name: 'Test Field',
                  label: () => const Text('Enter your name'),
                  filled: (value) => Text('Name: $value'),
                );
              },
            ),
          ),
        ),
      );

      // Should find the InkWell widget (the tappable container)
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.text('Enter your name'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('should show filled state when controller has value', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'John Doe');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final textField = TextFormField(
                  controller: controller,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                );

                return textField.flex(
                  context: context,
                  name: 'Test Field',
                  label: () => const Text('Enter your name'),
                  filled: (value) => Text('Hello, $value!'),
                );
              },
            ),
          ),
        ),
      );

      // Should show filled state
      expect(find.text('Hello, John Doe!'), findsOneWidget);
      expect(find.text('Enter your name'), findsNothing);

      controller.dispose();
    });

    testWidgets('should open dialog when tapped', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final textField = TextFormField(
                  controller: controller,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                );

                return textField.flex(
                  context: context,
                  name: 'Test Field',
                  label: () => const Text('Enter your name'),
                  filled: (value) => Text('Name: $value'),
                );
              },
            ),
          ),
        ),
      );

      // Tap the field
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Dialog should be open
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('should show custom button texts', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final textField = TextFormField(
                  controller: controller,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                );

                return textField.flex(
                  context: context,
                  name: 'Test Field',
                  resetText: 'Clear',
                  okText: 'Save',
                  label: () => const Text('Enter your name'),
                  filled: (value) => Text('Name: $value'),
                );
              },
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Check custom button texts
      expect(find.text('Clear'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);

      controller.dispose();
    });

    test('should handle controller text changes', () {
      final controller = TextEditingController();

      // Test empty state
      expect(controller.text, isEmpty);

      // Test filled state
      controller.text = 'Test Value';
      expect(controller.text, equals('Test Value'));

      // Test reset
      controller.text = '';
      expect(controller.text, isEmpty);

      controller.dispose();
    });

    test('should validate input correctly', () {
      // Test validator function
      String? validator(String? value) {
        if (value?.isEmpty ?? true) return 'Required';
        if (value!.length < 3) return 'Too short';
        return null;
      }

      expect(validator(null), equals('Required'));
      expect(validator(''), equals('Required'));
      expect(validator('ab'), equals('Too short'));
      expect(validator('abc'), isNull);
      expect(validator('valid input'), isNull);
    });
  });
}
