# NetflixClone
A Netflix-style streaming app built using SwiftUI, designed to showcase modern iOS UI, clean architecture, and dynamic content playback.

### ✅ Features
🏠 Home Screen
- Displays trending and popular shows in scrollable carousels.

🎥 Detail View
- Rich details for selected titles: description, release date, ratings, and trailers.

🌐 TMDB Integration

- Using local json data for Home screen
- Fetches real-time data using Movide Database (TMDB) API


🏗️ Architecture & Tech Stack

- SwiftUI – Declarative UI framework
- MVVM – Modularity with clear separation of concerns
- TMDB API – Backend data source

```swift
Netflix/
├── App/                          // Entry point
├── Models/                      // Data structures (Movie, Genre, etc.)
├── Views/                       // UI components: Home, Search, Details, Downloads
├── ViewModels/                  // Logic & data binding for Views
├── Utilities/                   // NetworkManager, image caching, helpers
└── Assets/                      // App resources and placeholders
```


# User experience


https://github.com/user-attachments/assets/f4e79574-2b3a-4374-a525-e61d76afc48c



https://github.com/user-attachments/assets/d6dd460e-8dd4-4ff1-a46c-c766d5b86911



https://github.com/user-attachments/assets/e7f0b7d9-614d-492c-b9da-ca0fd08a77cc



### 🚀 Getting Started
Clone the repo:
```basg
git clone https://github.com/bogamythrai/NetflixClone.git
cd NetflixClone
```

### 🧩 Contributing
Contributions welcome! Feel free to:
- File issues or feature requests
- Submit pull requests with improvements

### 📄 License
Open‑source under the MIT License. See LICENSE for details.
