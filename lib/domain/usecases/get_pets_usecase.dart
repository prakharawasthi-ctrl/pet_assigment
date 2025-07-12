// domain/usecases/get_pets_usecase.dart
import 'package:pet_adoption_app/domain/entities/pet.dart';
import 'package:pet_adoption_app/domain/repositories/pet_repository.dart';

class GetPetsUseCase {
  final PetRepository repository;

  GetPetsUseCase(this.repository);

  Future<List<Pet>> call() async {
    return await repository.getPets();
  }
}

// domain/usecases/get_favorite_pets_usecase.dart
class GetFavoritePetsUseCase {
  final PetRepository repository;

  GetFavoritePetsUseCase(this.repository);

  Future<List<Pet>> call() async {
    return await repository.getFavoritePets();
  }
}

// domain/usecases/get_adopted_pets_usecase.dart
class GetAdoptedPetsUseCase {
  final PetRepository repository;

  GetAdoptedPetsUseCase(this.repository);

  Future<List<Pet>> call() async {
    return await repository.getAdoptedPets();
  }
}

// domain/usecases/toggle_favorite_usecase.dart
class ToggleFavoriteUseCase {
  final PetRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String petId) async {
    await repository.toggleFavorite(petId);
  }
}

// domain/usecases/adopt_pet_usecase.dart
class AdoptPetUseCase {
  final PetRepository repository;

  AdoptPetUseCase(this.repository);

  Future<void> call(String petId) async {
    await repository.adoptPet(petId);
  }
}