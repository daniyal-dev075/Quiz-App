# 📚 Flutter Quiz App

A beautifully designed and interactive Flutter Quiz App powered by Firebase. Users can sign up, log in using email and password, attempt a 10-question timed quiz, and view their final score at the end. The app uses `Provider` for efficient state management.

---

## 🚀 Features

- 👤 **Email & Password Authentication** (via Firebase Auth)
- 📝 **Real-time Questions** fetched from Firebase Firestore
- ⏱️ **15-second Timer** per question with visual progress and color transition
- ✅ **Instant Feedback** after selecting an answer or when time runs out
- 📊 **Auto Score Tracking** for correct answers only
- ⌛ **Auto Navigation** to next question after time up or answer selection
- 🏁 **Score View Screen** at the end with the final score
- 📱 Fully responsive using `flutter_screenutil`

---

## 🛠️ Tech Stack

| Component         | Technology              |
|------------------|-------------------------|
| Frontend         | Flutter (Dart)          |
| Auth & Database  | Firebase (Auth + Firestore) |
| State Management | Provider                |
| Styling          | ScreenUtil              |

---

## 🔐 Authentication Flow

- Users can **Sign Up** using a valid email and password.
- Users can **Log In** using the registered email and password.
- No phone authentication is used.
- Firebase Authentication handles login state persistence.

---

## 🧠 Quiz Flow

1. After login, users land on the **Quiz Instructions** screen.
2. Tapping **"Get Started"** begins the quiz.
3. The app loads **10 questions** from Firestore (under `quizzes/quiz1/questions`).
4. Each question:
   - Has **4 options**
   - Includes a **15-second countdown**
   - Shows **timer progress bar** that fades from **green to red**
5. Answer selection:
   - Gives instant feedback:
     - ✅ Correct: `"🎉 Congratulations! You answered correct"`
     - ❌ Incorrect: `"❌ Sorry, you are wrong. Correct Answer: ..."`
   - Increases score by `+1` if correct (only once per question)
6. If time runs out:
   - Automatically marks as incorrect
   - Shows feedback `"⏰ Time is up!"` and proceeds after 2 seconds
7. On last question:
   - Redirects to the **ScoreView** screen with total score out of 10

---

## 🧠 Timer Implementation

- Timer runs via `Timer.periodic`
- On timeout: 
  - Feedback is triggered automatically
  - Auto-navigates to next question
- Timer resets on each new question

---

## 🔄 State Management

- Managed using **Provider**
- `QuestionViewModel` holds:
  - Question list
  - Current index
  - Score
  - Timer state
  - Selected answer and feedback
- Updates UI reactively via `notifyListeners()`

---

## 📁 Firestore Structure

```
quizzes (Collection)
└── quiz1 (Document)
    └── questions (Sub-collection)
        ├── questionNumber: 1
        ├── question: "What is Flutter?"
        ├── options: [ ... ]
        └── answer: "A UI toolkit"
```

---

## 📷 UI Overview

| Screen             | Description                              |
|-------------------|------------------------------------------|
| LoginView         | Email/Password Login                     |
| SignupView        | Register a new account                   |
| InstructionView   | Quiz instructions & Start button         |
| QuizView          | Question + Timer + Options + Feedback    |
| ScoreView         | Final score out of 10                    |

---

## 🧪 How to Run

1. Clone this repo  
   `git clone https://github.com/your-username/quiz_app.git`

2. Navigate into project folder  
   `cd quiz_app`

3. Get dependencies  
   `flutter pub get`

4. Set up Firebase:
   - Add your `google-services.json` (Android)
   - Enable Firestore and Firebase Auth (email/password)
   - Add question data as described above

5. Run the app  
   `flutter run`

---

## 🔚 Future Improvements

- Add **Phone Authentication**
- Add **Leaderboard** to store high scores
- Add **Category-wise quizzes**
- Add **User Profile** page

### 📽️ Demo Video

[Watch the Demo Video](https://drive.google.com/file/d/1cEcNinRtrXqPLwu6OreSOEt4IC8BCc8d/view?usp=drivesdk)
