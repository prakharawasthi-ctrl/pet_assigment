import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/presentation/blocs/pet_bloc.dart';
import 'package:pet_adoption_app/presentation/pages/details_page.dart';
import 'package:pet_adoption_app/presentation/widgets/pet_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pets'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is PetLoaded) {
            if (state.favoritedPets.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No favorite pets yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.favoritedPets.length,
              itemBuilder: (context, index) {
                final pet = state.favoritedPets[index];
                return PetCard(
                  pet: pet,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(pet: pet),
                      ),
                    );
                  },
                  onFavoriteToggle: () {
                    context.read<PetBloc>().add(ToggleFavoriteEvent(pet.id));
                  },
                );
              },
            );
          }
          
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}