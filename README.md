
# Kickoff 🏆⚽🏀🎾🏏

Kickoff is a **sports iOS application** built with **Swift** using the **MVP architecture**.  
Explore leagues, matches, teams, and players for four popular sports: **Football, Basketball, Tennis, and Cricket**.

---

## 🚀 Features

- 🎬 Animated Splash Screen with smooth animation  
- 👣 Onboarding screen shown only on the first launch  
- 🎛️ Tab bar with two main sections:  
  - 🏠 **Home**: Choose a sport and browse its leagues  
  - ⭐ **Favourites**: Save and quickly access favourite leagues  
- 📋 Detailed League screen showing:  
  - ⏳ Last and upcoming matches  
  - 👥 Teams or players (tennis only shows players)  
  - 🎨 Custom UI adapted for each sport  
- 🏟️ Team Details screen (for team-based sports) with info about players, coaches, etc.  
- 💾 Save favourite leagues locally using **CoreData**  
- 🌙 Dark Mode support  
- 🔄 Handles device rotation seamlessly  
- 🌍 Localization for English 🇺🇸, Arabic 🇸🇦 (RTL), and Spanish 🇪🇸  
- 📶 Offline mode handling:  
  - 📡 Detects network status using **Reachability**  
  - 🚫 Prevents navigation when offline to avoid errors  

---

## 🛠️ Technologies

| ⚙️ Technology       | 📝 Description                  |
| ------------------- | ------------------------------ |
| 🧑‍💻 Swift           | Programming language            |
| 🏗️ MVP Architecture  | Code organization               |
| 📡 Alamofire         | Networking                     |
| 🗃️ CoreData          | Local storage for favourites    |
| 🔑 UserDefaults      | Onboarding state & preferences  |
| 📶 Reachability      | Network connectivity monitoring |
| 🎨 UIKit             | User interface and custom views |

---

## 📡 API

Kickoff uses the powerful [AllSportsAPI](https://allsportsapi.com/) to fetch live and up-to-date sports data, including matches, teams, players, and leagues.

---

### 👥 **Team Members**

**Kickoff** is a project developed by a passionate team:

- **Abdelrahman Atia**  
- **Abdelrahman Kamel**  

---

## 💻 Installation

```bash
# 📥 Clone the repo
git clone https://github.com/AAtia10/Kickoff.git

# 📂 Open the project in Xcode
open Kickoff.xcodeproj

# 💼 If using CocoaPods, install dependencies
pod install

# ▶️ Run the app on your simulator or device
```

---

## 📝 Contributing

Contributions are always welcome! 🙌

If you want to improve Kickoff, please follow these steps:

1. Fork the repository  
2. Create a new branch (`git checkout -b feature/your-feature`)  
3. Make your changes and commit them (`git commit -m 'Add some feature'`)  
4. Push to the branch (`git push origin feature/your-feature`)  
5. Open a Pull Request describing your changes  

Please make sure your code follows the existing style and passes any tests.

---

## 🔗 Contact

For any questions, issues, or suggestions, feel free to reach out to the developers on LinkedIn:

- [Abdelrahman Atia](https://www.linkedin.com/in/abdelrahmanatia2024)  
- [Abdelrahman Kamel](https://www.linkedin.com/in/abdelrahmankamel00)  
