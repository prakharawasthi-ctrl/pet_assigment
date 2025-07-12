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

{
  "id": "1",
  "name": "Bella",
  "breed": "Golden Retriever",
  "age": 3,
  "price": 120.0,
  "description": "Friendly and loving companion.",
  "imageUrl": "https://example.com/image.jpg"
}

