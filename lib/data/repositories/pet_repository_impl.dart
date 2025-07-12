import 'package:pet_adoption_app/data/datasources/local_storage.dart';
import 'package:pet_adoption_app/data/datasources/pet_api.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';
import 'package:pet_adoption_app/domain/repositories/pet_repository.dart';

class PetRepositoryImpl implements PetRepository {
  final PetApiDataSource apiDataSource;
  final LocalStorage localDataSource;

  PetRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Pet>> getPets() async {
    final hasLocalData = await localDataSource.hasData();

    if (hasLocalData) {
      // ✅ Load from SharedPreferences first if available
      print('📦 Loading pets from SharedPreferences');
      return await localDataSource.getPets();
    } else {
      try {
        // 🌐 Fetch from API and store locally
        final pets = await apiDataSource.getPets();
        await localDataSource.savePets(pets);
        return pets;
      } catch (e) {
        print('❌ API failed and no local data: $e');
        return [];
      }
    }
  }

  @override
  Future<void> adoptPet(String petId) async {
    await localDataSource.adoptPet(petId);
  }

  @override
  Future<void> toggleFavorite(String petId) async {
    await localDataSource.toggleFavorite(petId);
  }

  @override
  Future<List<Pet>> getAdoptedPets() async {
    return await localDataSource.getAdoptedPets();
  }

  @override
  Future<List<Pet>> getFavoritePets() async {
    return await localDataSource.getFavoritePets();
  }
}
