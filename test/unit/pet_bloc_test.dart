import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';
import 'package:pet_adoption_app/domain/repositories/pet_repository.dart';
import 'package:pet_adoption_app/presentation/blocs/pet_bloc.dart';

class MockPetRepository extends Mock implements PetRepository {}

void main() {
  late PetBloc petBloc;
  late MockPetRepository mockPetRepository;

  setUp(() {
    mockPetRepository = MockPetRepository();
    petBloc = PetBloc(repository: mockPetRepository);
  });

  tearDown(() {
    petBloc.close();
  });

  const testPet = Pet(
    id: '1',
    name: 'Test Pet',
    breed: 'Test Breed',
    age: 2,
    price: 100.0,
    imageUrl: 'test_url',
    description: 'Test description',
    category: 'Test',
  );

  group('PetBloc', () {
    test('initial state is PetInitial', () {
      expect(petBloc.state, equals(PetInitial()));
    });

    blocTest<PetBloc, PetState>(
      'emits [PetLoading, PetLoaded] when LoadPetsEvent is added',
      build: () {
        when(() => mockPetRepository.getPets())
            .thenAnswer((_) async => [testPet]);
        return petBloc;
      },
      act: (bloc) => bloc.add(LoadPetsEvent()),
      expect: () => [
        PetLoading(),
        isA<PetLoaded>(),
      ],
    );

    blocTest<PetBloc, PetState>(
      'emits [PetLoading, PetError] when LoadPetsEvent fails',
      build: () {
        when(() => mockPetRepository.getPets())
            .thenThrow(Exception('Failed to load pets'));
        return petBloc;
      },
      act: (bloc) => bloc.add(LoadPetsEvent()),
      expect: () => [
        PetLoading(),
        isA<PetError>(),
      ],
    );
  });
}