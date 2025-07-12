import 'package:pet_adoption_app/domain/entities/pet.dart';

class PetModel {
  final String id;
  final String name;
  final String breed;
  final int age;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final bool isAdopted;
  final bool isFavorited;
  final DateTime? adoptedDate;

  PetModel({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.isAdopted = false,
    this.isFavorited = false,
    this.adoptedDate,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      isAdopted: json['isAdopted'] ?? false,
      isFavorited: json['isFavorited'] ?? false,
      adoptedDate: json['adoptedDate'] != null
          ? DateTime.parse(json['adoptedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'isAdopted': isAdopted,
      'isFavorited': isFavorited,
      'adoptedDate': adoptedDate?.toIso8601String(),
    };
  }

  Pet toEntity() {
    return Pet(
      id: id,
      name: name,
      breed: breed,
      age: age,
      price: price,
      imageUrl: imageUrl,
      description: description,
      category: category,
      isAdopted: isAdopted,
      isFavorited: isFavorited,
      adoptedDate: adoptedDate,
    );
  }

  factory PetModel.fromEntity(Pet pet) {
    return PetModel(
      id: pet.id,
      name: pet.name,
      breed: pet.breed,
      age: pet.age,
      price: pet.price,
      imageUrl: pet.imageUrl,
      description: pet.description,
      category: pet.category,
      isAdopted: pet.isAdopted,
      isFavorited: pet.isFavorited,
      adoptedDate: pet.adoptedDate,
    );
  }

  PetModel copyWith({
    String? id,
    String? name,
    String? breed,
    int? age,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
    bool? isAdopted,
    bool? isFavorited,
    DateTime? adoptedDate,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorited: isFavorited ?? this.isFavorited,
      adoptedDate: adoptedDate ?? this.adoptedDate,
    );
  }
}