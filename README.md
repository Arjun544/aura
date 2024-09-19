# Aura - Mood Tracking and Mental Wellness App

Aura is a sophisticated mood tracking and mental wellness application built with Flutter & Supabase. It helps users monitor their emotional well-being, visualize mood patterns, and gain insights into their mental health.

## Supabase 2024 Hackathon

- This project was developed as part of the Supabase 2024 Hackathon.
- Deadline :  September 13th 2024 - September 22nd 2024

## Key Features

### 1. Mood Logging
- Log daily moods using text, emojis, or images.
- AI-powered mood analysis and categorization.
- Add notes to provide context for each mood entry.

### 2. Mood Calendar
- Calendar view displays mood entries for each day.
- Toggle between calendar and list views for mood history.
- Easy navigation through past entries.

### 3. Mood Statistics
- Visualize mood trends with interactive bar charts.
- View percentage breakdowns of different mood categories.
- Identify top moods over time.

### 4. Streak Tracking
- Motivational streak counter for consistent mood logging.
- Display current streak and all-time longest streak.

### 5. Recommended Activities
- AI-generated activity suggestions based on the user's current mood.
- Personalized recommendations to improve mental well-being.

### 6. User Profiles
- Support for both anonymous and Google sign-in.
- Edit profile information, including display name.

### 7. Settings
- Customize app preferences.
- Manage account settings and sign-out functionality.

## Tech Stack

### Core
- **Flutter & Dart**
- **Supabase**

### State Management & Architecture
- **Riverpod**
  - hooks_riverpod
  - flutter_riverpod
- **Flutter Hooks**

### Backend & Authentication
- **Supabase Flutter**
- **Flutter AppAuth**

### Routing
- **Go Router**

### UI & Styling
- **Flutter ScreenUtil**
- **Flutter SVG**
- **Loading Animation Widget**
- **Lottie**
- **Flutter Remix**
- **Ficonsax**
- **Blobs**
- **Flutter Animate**
- **Cached Network Image**

### Data Handling & Utilities
- **FPDart**
- **Crypto**
- **Date Format**
- **Easy Date Timeline**
- **Timeago**
- **Timeago Flutter**

### Charts & Visualizations
- **FL Chart**

### Image Handling
- **Image Picker**
- **Permission Handler**

### Pagination
- **Infinite Scroll Pagination**

### AI Integration
- **Google Generative AI**

### Environment Configuration
- **Flutter Dotenv**

### Development Tools
- **Icons Launcher**
- **Flutter Lints**

### Assets
- Custom fonts (Poppins)
- Various asset folders for brand, animations, emojis, and images

## Project Structure

- `lib/`
  - `core/`: Core utilities, constants, and imports.
  - `models/`: Data models for the application.
  - `providers/`: Riverpod providers for state management.
  - `screens/`: UI screens for different app sections.
  - `services/`: Business logic and API integration.
  - `widgets/`: Reusable UI components.
  - `utils/`: Utility functions and helpers.

## Getting Started

1. Clone the repository:
   ```
   git clone https://github.com/your-username/aura-app.git
   cd aura-app
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Set up environment variables:
   Create a `.env` file in the root directory with the following variables:
   ```
   SUPABASE_URL=your_supabase_project_url
   ANON_KEY=your_supabase_anon_key
   GOOGLE_CLIENT_ID_IOS=your_google_client_id_for_ios
   GOOGLE_CLIENT_ID_ANDROID=your_google_client_id_for_android
   GEMINI_API_KEY=your_gemini_api_key
   ```

4. Initialize Supabase:
   The app uses Supabase for backend services. Make sure you have a Supabase project set up. The `supabaseInit()` function in `lib/providers/common/supabase_provider.dart` will handle the initialization using the environment variables.

5. Configure Google Sign-In:
   Follow the instructions in the Flutter documentation to set up Google Sign-In for both iOS and Android platforms. Update the `GOOGLE_CLIENT_ID_IOS` and `GOOGLE_CLIENT_ID_ANDROID` in your `.env` file.

6. Set up Gemini API:
   Obtain an API key for the Gemini AI service and add it to the `GEMINI_API_KEY` variable in your `.env` file.

7. Run the app:
   ```
   flutter run
   ```

Note: Make sure you have Flutter and Dart SDK installed on your machine before running the app. For more information on setting up Flutter, visit the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

## Contributing

We welcome contributions to Aura! Please read our contributing guidelines before submitting pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.


## Screenshots

| ![App Screenshot 1](https://tinyurl.com/mr3f26ej) | ![App Screenshot 2](https://tinyurl.com/bdcrsnvr) |
| --- | --- |
| Screenshot 1 | Screenshot 2 |