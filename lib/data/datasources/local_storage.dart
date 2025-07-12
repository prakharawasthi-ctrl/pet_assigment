import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';

class LocalStorage {
  static const String _petsKey = 'pets_data';
  static SharedPreferences? _prefs;
  
  static Future<void> initialize() async {
    try {
      print('🔧 Initializing SharedPreferences...');
      _prefs = await SharedPreferences.getInstance();
      print('✅ SharedPreferences initialized successfully');
      
      // Debug: Print existing data
      await _debugPrintAllData();
      
    } catch (e) {
      print('❌ Error initializing SharedPreferences: $e');
      rethrow;
    }
  }
  
  static SharedPreferences get _preferences {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call LocalStorage.initialize() first.');
    }
    return _prefs!;
  }
  
  Future<void> savePets(List<Pet> pets) async {
    try {
      print('💾 Saving ${pets.length} pets to SharedPreferences...');
      
      // Convert pets to JSON
      final List<Map<String, dynamic>> petsJson = pets
          .map((pet) => PetModel.fromEntity(pet).toJson())
          .toList();
      
      // Save to SharedPreferences
      final String petsString = json.encode(petsJson);
      await _preferences.setString(_petsKey, petsString);
      
      print('✅ Saved ${pets.length} pets to SharedPreferences');
      
      // Verify data was saved
      final savedData = _preferences.getString(_petsKey);
      if (savedData != null) {
        final decodedData = json.decode(savedData) as List;
        print('🔍 Verification: ${decodedData.length} pets saved successfully');
      }
      
      await _debugPrintAllData();
      
    } catch (e) {
      print('❌ Error saving pets: $e');
      rethrow;
    }
  }
  
  Future<List<Pet>> getPets() async {
    try {
      print('📖 Getting pets from SharedPreferences...');
      
      final String? petsString = _preferences.getString(_petsKey);
      
      if (petsString == null || petsString.isEmpty) {
        print('📭 No pets found in SharedPreferences');
        return [];
      }
      
      // Decode JSON
      final List<dynamic> petsJson = json.decode(petsString);
      
      // Convert to Pet entities
      final List<Pet> pets = petsJson
          .map((json) => PetModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
      
      print('✅ Retrieved ${pets.length} pets from SharedPreferences');
      
      // Print details of retrieved pets
      for (var pet in pets) {
        print('  🐕 ${pet.name} - Favorited: ${pet.isFavorited}, Adopted: ${pet.isAdopted}');
      }
      
      return pets;
      
    } catch (e) {
      print('❌ Error getting pets: $e');
      return [];
    }
  }
  
  Future<void> adoptPet(String petId) async {
    try {
      print('🏠 Adopting pet: $petId');
      
      // Get current pets
      final pets = await getPets();
      
      // Find and update the pet
      final petIndex = pets.indexWhere((pet) => pet.id == petId);
      
      if (petIndex != -1) {
        final pet = pets[petIndex];
        print('✅ Found pet to adopt: ${pet.name}');
        
        // Update the pet
        final updatedPet = pet.copyWith(
          isAdopted: true,
          adoptedDate: DateTime.now(),
        );
        
        // Replace in the list
        pets[petIndex] = updatedPet;
        
        // Save back to SharedPreferences
        await savePets(pets);
        
        print('✅ Pet adopted successfully');
        
        // Verify the change
        final verifyPets = await getPets();
        final verifyPet = verifyPets.firstWhere((p) => p.id == petId);
        print('🔍 Verification: Pet ${verifyPet.name} adopted status: ${verifyPet.isAdopted}');
        
      } else {
        print('❌ Pet not found: $petId');
      }
      
    } catch (e) {
      print('❌ Error adopting pet: $e');
      rethrow;
    }
  }
  
  Future<void> toggleFavorite(String petId) async {
    try {
      print('⭐ Toggling favorite for pet: $petId');
      
      // Get current pets
      final pets = await getPets();
      
      // Find and update the pet
      final petIndex = pets.indexWhere((pet) => pet.id == petId);
      
      if (petIndex != -1) {
        final pet = pets[petIndex];
        final currentStatus = pet.isFavorited;
        print('📍 Current favorite status: $currentStatus');
        
        // Update the pet
        final updatedPet = pet.copyWith(
          isFavorited: !currentStatus,
        );
        
        // Replace in the list
        pets[petIndex] = updatedPet;
        
        // Save back to SharedPreferences
        await savePets(pets);
        
        print('✅ Favorite toggled successfully');
        
        // Verify the change
        final verifyPets = await getPets();
        final verifyPet = verifyPets.firstWhere((p) => p.id == petId);
        print('🔍 Verification: Pet ${verifyPet.name} favorite status: ${verifyPet.isFavorited}');
        
      } else {
        print('❌ Pet not found: $petId');
      }
      
    } catch (e) {
      print('❌ Error toggling favorite: $e');
      rethrow;
    }
  }
  
  // Debug method to print all data
  static Future<void> _debugPrintAllData() async {
    try {
      print('🔍 === DEBUG: Current SharedPreferences Content ===');
      
      final String? petsString = _preferences.getString(_petsKey);
      
      if (petsString == null || petsString.isEmpty) {
        print('📭 SharedPreferences is empty');
      } else {
        final List<dynamic> petsJson = json.decode(petsString);
        print('📊 Total pets: ${petsJson.length}');
        
        for (int i = 0; i < petsJson.length; i++) {
          final petData = petsJson[i] as Map<String, dynamic>;
          print('🐾 [$i] ${petData['name']} - Fav: ${petData['isFavorited']}, Adopted: ${petData['isAdopted']}');
        }
      }
      
      print('🔍 === END DEBUG ===');
    } catch (e) {
      print('❌ Error in debug print: $e');
    }
  }
  
  // Public debug method
  Future<void> debugPrintData() async {
    await _debugPrintAllData();
  }
  
  // Method to check if data exists
  Future<bool> hasData() async {
    try {
      final String? petsString = _preferences.getString(_petsKey);
      return petsString != null && petsString.isNotEmpty;
    } catch (e) {
      print('❌ Error checking data: $e');
      return false;
    }
  }
  
  // Method to completely clear storage (for testing)
  Future<void> clearAll() async {
    try {
      await _preferences.remove(_petsKey);
      print('🗑️ SharedPreferences cleared completely');
    } catch (e) {
      print('❌ Error clearing SharedPreferences: $e');
    }
  }
  
  // Method to get favorites
  Future<List<Pet>> getFavoritePets() async {
    try {
      final pets = await getPets();
      return pets.where((pet) => pet.isFavorited).toList();
    } catch (e) {
      print('❌ Error getting favorite pets: $e');
      return [];
    }
  }
  
  // Method to get adopted pets
  Future<List<Pet>> getAdoptedPets() async {
    try {
      final pets = await getPets();
      return pets.where((pet) => pet.isAdopted).toList();
    } catch (e) {
      print('❌ Error getting adopted pets: $e');
      return [];
    }
  }
}