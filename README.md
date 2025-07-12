# 🐾 Pet Adoption App

A beautiful Flutter app that allows users to view, favorite, and adopt pets. It fetches data from an external API and also uses local storage to persist user actions like adoption and favoriting across app restarts.

## 📱 Features

- 🚀 Fetch pets from a remote API
- ❤️ Favorite and unfavorite pets
- 🏠 Adopt pets and track adoption history
- 💾 Store pet data locally using SharedPreferences
- 🔍 Search pets by name
- 📷 View full-screen pet images
- 🎉 Confetti animation on successful adoption
- 🌗 Light & Dark theme support (via BLoC)
- 🔄 Offline fallback using locally cached data
- 🔧 Clean architecture with BLoC, Repository, and DataSources

---

## 🔗 API Used

**Base URL**:  
https://api-ispj.onrender.com/api/pets
This API provides a list of pet data with the following fields:

```json
{
  "id": "1",
  "name": "Bella",
  "breed": "Golden Retriever",
  "age": 3,
  "price": 120.0,
  "description": "Friendly and loving companion.",
  "imageUrl": "https://example.com/image.jpg"
}
🧠 Architecture Overview
kotlin
Copy
Edit
lib/
├── core/
│   └── themes/
├── data/
│   ├── datasources/
│   │   ├── pet_api.dart
│   │   └── local_storage.dart
│   ├── models/
│   │   └── pet_model.dart
│   └── repositories/
│       └── pet_repository_impl.dart
├── domain/
│   ├── entities/
│   └── repositories/
├── presentation/
│   ├── blocs/
│   ├── pages/
│   └── widgets/
💾 Local Data Handling
The app uses shared_preferences to cache pet data locally. Once a pet is fetched from the API, it is saved to local storage and updated when:

A pet is adopted (isAdopted: true)

A pet is favorited (isFavorited: true)

This ensures offline support and state persistence after app restarts.

Local operations include:
savePets(List<Pet>)

getPets()

adoptPet(String petId)

toggleFavorite(String petId)

getAdoptedPets()

getFavoritePets()

🛠️ Setup Instructions
Prerequisites
Flutter SDK

Android Studio / VS Code

Android/iOS simulator or real device

Install Dependencies
bash
Copy
Edit
flutter pub get
Run the App
bash
Copy
Edit
flutter run
📸 Screenshots
Home Page	Pet Details	Adoption History

📦 Packages Used
Package	Description
flutter_bloc	State management
shared_preferences	Local data persistence
photo_view	Zoomable pet images
confetti	Celebration animation
intl	Date formatting

🚧 Future Improvements
🐾 Filter pets by breed/age

🔔 Notifications for new pets

📤 Upload your own pet for adoption

📱 Responsive design for tablets

👨‍💻 Developed By
Prakhar Awasthi
💼 Flutter & Backend Developer
📧 prakharawasthi.dev@gmail.com
🌐 LinkedIn | GitHub

📄 License
This project is licensed under the MIT License.

yaml
Copy
Edit

---

Let me know if you'd like this exported as a `README.md` file or want help automating screenshot captures or license file generation.








Ask ChatGPT
