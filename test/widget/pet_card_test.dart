import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';
import 'package:pet_adoption_app/presentation/widgets/pet_card.dart';

void main() {
  const testPet = Pet(
    id: '1',
    name: 'Test Pet',
    breed: 'Test Breed',
    age: 2,
    price: 100.0,
    imageUrl: 'https://example.com/test.jpg',
    description: 'Test description',
    category: 'Test',
  );

  testWidgets('PetCard displays pet information correctly', (tester) async {
    bool onTapCalled = false;
    bool onFavoriteCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PetCard(
            pet: testPet,
            onTap: () => onTapCalled = true,
            onFavoriteToggle: () => onFavoriteCalled = true,
          ),
        ),
      ),
    );

    expect(find.text('Test Pet'), findsOneWidget);
    expect(find.text('Test Breed • 2 years'), findsOneWidget);
    expect(find.text('\$100.00'), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(onTapCalled, isTrue);
  });
}