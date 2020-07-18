import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/widgets/buttons/custom_raised_button.dart';

void main() {
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: CustomRaisedButton(
        child: Text('Tap me'),
        onPressed: () => pressed = true,
      ),
    ));

    final button = find.byType(RaisedButton);

    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text('Tap me'), findsOneWidget);

    await tester.tap(button);
    expect(pressed, true);
  });
}
