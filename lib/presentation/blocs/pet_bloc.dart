import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';
import 'package:pet_adoption_app/domain/repositories/pet_repository.dart';

// Events
abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

class LoadPetsEvent extends PetEvent {}

class SearchPetsEvent extends PetEvent {
  final String query;
  
  const SearchPetsEvent(this.query);
  
  @override
  List<Object?> get props => [query];
}

class AdoptPetEvent extends PetEvent {
  final String petId;
  
  const AdoptPetEvent(this.petId);
  
  @override
  List<Object?> get props => [petId];
}

class ToggleFavoriteEvent extends PetEvent {
  final String petId;
  
  const ToggleFavoriteEvent(this.petId);
  
  @override
  List<Object?> get props => [petId];
}

class RefreshPetsEvent extends PetEvent {}

// States
abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object?> get props => [];
}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<Pet> pets;
  final List<Pet> filteredPets;
  final List<Pet> adoptedPets;
  final List<Pet> favoritedPets;
  
  const PetLoaded({
    required this.pets,
    required this.filteredPets,
    required this.adoptedPets,
    required this.favoritedPets,
  });
  
  @override
  List<Object?> get props => [pets, filteredPets, adoptedPets, favoritedPets];
}

class PetError extends PetState {
  final String message;
  
  const PetError(this.message);
  
  @override
  List<Object?> get props => [message];
}

// BLoC
class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository repository;
  
  PetBloc({required this.repository}) : super(PetInitial()) {
    on<LoadPetsEvent>(_onLoadPets);
    on<SearchPetsEvent>(_onSearchPets);
    on<AdoptPetEvent>(_onAdoptPet);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<RefreshPetsEvent>(_onRefreshPets);
  }

  Future<void> _onLoadPets(LoadPetsEvent event, Emitter<PetState> emit) async {
    emit(PetLoading());
    try {
      final pets = await repository.getPets();
      final adoptedPets = pets.where((pet) => pet.isAdopted).toList()
        ..sort((a, b) => (b.adoptedDate ?? DateTime.now())
            .compareTo(a.adoptedDate ?? DateTime.now()));
      final favoritedPets = pets.where((pet) => pet.isFavorited).toList();
      
      emit(PetLoaded(
        pets: pets,
        filteredPets: pets,
        adoptedPets: adoptedPets,
        favoritedPets: favoritedPets,
      ));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onSearchPets(SearchPetsEvent event, Emitter<PetState> emit) async {
    if (state is PetLoaded) {
      final currentState = state as PetLoaded;
      final filteredPets = currentState.pets
          .where((pet) => pet.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      
      emit(PetLoaded(
        pets: currentState.pets,
        filteredPets: filteredPets,
        adoptedPets: currentState.adoptedPets,
        favoritedPets: currentState.favoritedPets,
      ));
    }
  }

  Future<void> _onAdoptPet(AdoptPetEvent event, Emitter<PetState> emit) async {
    if (state is PetLoaded) {
      final currentState = state as PetLoaded;
      try {
        await repository.adoptPet(event.petId);
        final updatedPets = currentState.pets.map((pet) {
          if (pet.id == event.petId) {
            return pet.copyWith(isAdopted: true, adoptedDate: DateTime.now());
          }
          return pet;
        }).toList();
        
        final adoptedPets = updatedPets.where((pet) => pet.isAdopted).toList()
          ..sort((a, b) => (b.adoptedDate ?? DateTime.now())
              .compareTo(a.adoptedDate ?? DateTime.now()));
        
        emit(PetLoaded(
          pets: updatedPets,
          filteredPets: updatedPets,
          adoptedPets: adoptedPets,
          favoritedPets: currentState.favoritedPets,
        ));
      } catch (e) {
        emit(PetError(e.toString()));
      }
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<PetState> emit) async {
    if (state is PetLoaded) {
      final currentState = state as PetLoaded;
      try {
        await repository.toggleFavorite(event.petId);
        final updatedPets = currentState.pets.map((pet) {
          if (pet.id == event.petId) {
            return pet.copyWith(isFavorited: !pet.isFavorited);
          }
          return pet;
        }).toList();
        
        final favoritedPets = updatedPets.where((pet) => pet.isFavorited).toList();
        
        emit(PetLoaded(
          pets: updatedPets,
          filteredPets: updatedPets,
          adoptedPets: currentState.adoptedPets,
          favoritedPets: favoritedPets,
        ));
      } catch (e) {
        emit(PetError(e.toString()));
      }
    }
  }

  Future<void> _onRefreshPets(RefreshPetsEvent event, Emitter<PetState> emit) async {
    add(LoadPetsEvent());
  }
}