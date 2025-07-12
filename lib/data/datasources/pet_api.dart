import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:pet_adoption_app/domain/entities/pet.dart';

class PetApiDataSource {
  static const String baseUrl = 'https://api-ispj.onrender.com/api/pets';

  Future<List<Pet>> getPets() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/pets'))
          .timeout(const Duration(seconds: 5)); // Timeout after 5 seconds

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PetModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print("API request failed or timed out. Using mock data. Error: $e");
      return _getMockPets(); // Fallback to hardcoded data
    }
  }

  List<Pet> _getMockPets() {
    final mockPets = [
      {
        'id': '1',
        'name': 'Buddy',
        'breed': 'Golden Retriever',
        'age': 3,
        'price': 500.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1552053831-71594a27632d?w=400',
        'description':
            'A friendly and energetic Golden Retriever who loves to play fetch and swim.',
        'category': 'Dog',
      },
      {
        'id': '2',
        'name': 'Luna',
        'breed': 'Persian',
        'age': 2,
        'price': 300.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400',
        'description':
            'A gentle and calm Persian cat who enjoys quiet afternoons and gentle pets.',
        'category': 'Cat',
      },
      {
        'id': '3',
        'name': 'Max',
        'breed': 'German Shepherd',
        'age': 4,
        'price': 750.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?w=400',
        'description':
            'A loyal and intelligent German Shepherd, perfect for active families.',
        'category': 'Dog',
      },
      {
        'id': '4',
        'name': 'Whiskers',
        'breed': 'British Shorthair',
        'age': 1,
        'price': 400.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1513245543132-31f507417b26?w=400',
        'description':
            'A playful kitten with beautiful blue eyes and a curious personality.',
        'category': 'Cat',
      },
      {
        'id': '5',
        'name': 'Rocky',
        'breed': 'Bulldog',
        'age': 5,
        'price': 600.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=400',
        'description':
            'A calm and gentle Bulldog who loves children and quiet environments.',
        'category': 'Dog',
      },
      {
        'id': '6',
        'name': 'Mittens',
        'breed': 'Maine Coon',
        'age': 3,
        'price': 550.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1574144611937-0df059b5ef3e?w=400',
        'description':
            'A large and fluffy Maine Coon with a gentle giant personality.',
        'category': 'Cat',
      },
      {
        'id': '7',
        'name': 'Charlie',
        'breed': 'Beagle',
        'age': 2,
        'price': 450.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1551717743-49959800b1f6?w=400',
        'description':
            'An energetic Beagle who loves exploring and following scents.',
        'category': 'Dog',
      },
      {
        'id': '8',
        'name': 'Shadow',
        'breed': 'Russian Blue',
        'age': 4,
        'price': 650.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=400',
        'description':
            'A sophisticated Russian Blue with striking green eyes and calm demeanor.',
        'category': 'Cat',
      },
      {
        'id': '9',
        'name': 'Bella',
        'breed': 'Labrador',
        'age': 1,
        'price': 520.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=400',
        'description':
            'A young and playful Labrador who loves water and fetch games.',
        'category': 'Dog',
      },
      {
        'id': '10',
        'name': 'Smokey',
        'breed': 'Siamese',
        'age': 6,
        'price': 380.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e?w=400',
        'description':
            'A talkative and affectionate Siamese cat who loves attention.',
        'category': 'Cat',
      },
       {
    'id': '11',
    'name': 'Simba',
    'breed': 'Shih Tzu',
    'age': 2,
    'price': 460.0,
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwp6HF-Bgpwha9_N0brjO6MCt3YD-NGFM42A&s',
    'description':
        'An affectionate Shih Tzu with a fluffy coat and a love for cuddles.',
    'category': 'Dog',
  },
  {
    'id': '12',
    'name': 'Cleo',
    'breed': 'Bengal',
    'age': 3,
    'price': 620.0,
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcFKzv3xyXR0pDPeW0YHN8xpRRvQ7SkGYNUg&s',
    'description':
        'An adventurous Bengal cat with striking patterns and high energy.',
    'category': 'Cat',
  },
  {
    'id': '13',
    'name': 'Oscar',
    'breed': 'Poodle',
    'age': 4,
    'price': 680.0,
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2xb585nZpaMM-IDq3ERKW6pbteX-d9u5Muw&s',
    'description':
        'A smart and elegant Poodle, ideal for families who enjoy an obedient companion.',
    'category': 'Dog',
  },
  {
    'id': '14',
    'name': 'Nala',
    'breed': 'Sphynx',
    'age': 1,
    'price': 700.0,
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpF9EHJK99JqzDhQ3VtK0o2B9MN8cPvQGXjg&s',
    'description':
        'A hairless Sphynx cat that is friendly, curious, and loves warmth.',
    'category': 'Cat',
  },
    ];

    return mockPets.map((json) => PetModel.fromJson(json).toEntity()).toList();
  }
}
