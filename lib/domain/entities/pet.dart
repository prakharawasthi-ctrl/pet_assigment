import 'package:equatable/equatable.dart';

class Pet extends Equatable {
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

  const Pet({
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

  Pet copyWith({
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
    return Pet(
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

  @override
  List<Object?> get props => [
        id,
        name,
        breed,
        age,
        price,
        imageUrl,
        description,
        category,
        isAdopted,
        isFavorited,
        adoptedDate,
      ];
}