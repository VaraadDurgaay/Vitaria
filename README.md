# Vitaria

A comprehensive healthcare management application built with Flutter and FastAPI. Vitaria helps patients manage their medical records, prescriptions, appointments, and interact with an AI-powered healthcare assistant.

## 🏥 Features

- **User Authentication**: Secure login/signup with email and Google Sign-In support
- **Prescription Management**: Create, view, and manage prescriptions
- **Medical Records**: Upload and store medical records with image processing
- **Appointment Scheduling**: Schedule and manage appointments with Google Calendar integration
- **AI Chatbot**: Interactive healthcare assistant powered by OpenAI
- **Reports Generation**: Generate and view medical reports
- **Timeline View**: Visualize medical history in a timeline format
- **Calendar Integration**: Sync appointments with Google Calendar

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Packages**:
  - `google_sign_in` - Google authentication
  - `http` - HTTP client for API calls
  - `image_picker` - Image selection from device
  - `table_calendar` - Calendar widget
  - `flutter_staggered_grid_view` - Grid layouts
  - `font_awesome_flutter` - Icon library

### Backend
- **FastAPI** - Modern Python web framework
- **MongoDB** - NoSQL database
- **SQLAlchemy** - SQL toolkit and ORM
- **OpenAI API** - AI chatbot integration
- **Google Calendar API** - Calendar synchronization
- **Pillow** - Image processing

## 📁 Project Structure

```
Vitaria/
├── Frontend/              # Flutter mobile application
│   ├── lib/
│   │   ├── main.dart
│   │   ├── loginpage.dart
│   │   ├── signuppage.dart
│   │   ├── chat_ai_screen.dart
│   │   ├── calenderfinal.dart
│   │   ├── timeline.dart
│   │   └── ...
│   ├── Assets/           # Images and assets
│   └── pubspec.yaml      # Flutter dependencies
│
├── backend/              # FastAPI backend server
│   ├── main.py          # FastAPI application entry point
│   ├── models/          # Data models
│   │   ├── user.py
│   │   ├── appointment.py
│   │   ├── prescription.py
│   │   ├── medical_record.py
│   │   ├── reports.py
│   │   └── chatbot.py
│   ├── routes/          # API route handlers
│   │   ├── auth_routes.py
│   │   ├── appointment_routes.py
│   │   ├── prescription_routes.py
│   │   ├── reports_routes.py
│   │   ├── chatbot_routes.py
│   │   └── upload_routes.py
│   ├── utils/           # Utility functions
│   │   ├── google_calendar.py
│   │   └── image_processing.py
│   ├── database/        # Database configuration
│   │   └── connection.py
│   └── requirements.txt # Python dependencies
│
├── README.md
├── privacy_policy.md
└── terms_of_service.md
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.7.0 or higher)
- **Dart SDK**
- **Python** 3.8 or higher
- **MongoDB** (local or cloud instance)
- **Google Cloud Project** (for Google Sign-In and Calendar API)
- **OpenAI API Key** (for chatbot functionality)

### Installation

#### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Create a virtual environment:
```bash
python -m venv venv
```

3. Activate the virtual environment:
   - **Windows**: `venv\Scripts\activate`
   - **macOS/Linux**: `source venv/bin/activate`

4. Install dependencies:
```bash
pip install -r requirements.txt
```

5. Create a `.env` file in the backend directory:
```env
MONGODB_URI=your_mongodb_connection_string
OPENAI_API_KEY=your_openai_api_key
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
```

6. Download Google Calendar API credentials:
   - Go to [Google Developer Console](https://console.developers.google.com/)
   - Create a project and enable Google Calendar API
   - Create OAuth 2.0 credentials (Desktop app type)
   - Download the JSON file and place it in the backend directory

7. Run the FastAPI server:
```bash
uvicorn main:app --reload
```

The API will be available at `http://localhost:8000`

#### Frontend Setup

1. Navigate to the Frontend directory:
```bash
cd Frontend
```

2. Install Flutter dependencies:
```bash
flutter pub get
```

3. Update the API base URL in your Flutter code (if needed):
   - The default backend URL is `https://vitaria.onrender.com`
   - For local development, update to `http://localhost:8000`

4. Run the Flutter app:
```bash
flutter run
```

## 📡 API Endpoints

### Authentication
- `POST /auth/login` - User login
- `POST /auth/signup` - User registration

### Prescriptions
- `POST /prescriptions` - Create a new prescription
- `GET /prescriptions` - Get all prescriptions

### Medical Records
- `POST /upload` - Upload medical record/image
- `GET /records` - Get all medical records

### Reports
- `POST /reports` - Generate a new report

### Appointments
- `POST /appointments` - Create a new appointment
- `GET /appointments` - Get all appointments

### Chatbot
- `POST /chatbot` - Send a message to the AI chatbot

## 🔧 Configuration

### Google Sign-In Setup
1. Create a project in [Google Cloud Console](https://console.cloud.google.com/)
2. Enable Google Sign-In API
3. Configure OAuth consent screen
4. Create OAuth 2.0 Client ID for Android/iOS
5. Add the client ID to your Flutter app configuration

### MongoDB Setup
- Use MongoDB Atlas (cloud) or local MongoDB instance
- Update the connection string in the `.env` file

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

This is a PBL (Project-Based Learning) project. Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is part of a PBL (Project-Based Learning) initiative.

## 📝 Additional Documentation

- [Privacy Policy](privacy_policy.md)
- [Terms of Service](terms_of_service.md)

## 🐛 Troubleshooting

### Backend Issues
- Ensure MongoDB is running and accessible
- Verify all environment variables are set correctly
- Check that Google Calendar API credentials are properly configured

### Frontend Issues
- Run `flutter clean` and `flutter pub get` if dependencies fail
- Ensure Flutter SDK version matches requirements (^3.7.0)
- Check that API base URL is correctly configured

## 📞 Support

For issues and questions, please open an issue in the repository.

---

**Note**: This project requires API keys and credentials for full functionality. Make sure to configure all necessary services before running the application.
