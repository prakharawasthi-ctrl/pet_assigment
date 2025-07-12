import 'package:pet_adoption_app/domain/entities/pet.dart';

abstract class PetRepository {
  Future<List<Pet>> getPets();
  Future<void> adoptPet(String petId);
  Future<void> toggleFavorite(String petId);
  Future<List<Pet>> getAdoptedPets();
  Future<List<Pet>> getFavoritePets();
}