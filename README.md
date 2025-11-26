# TodoApp - Flutter

## Project Overview
**TodoApp** is a Flutter application that demonstrates three different state management approaches: **Provider**, **GetX**, and **Cubit (Bloc)**. The app allows users to manage their tasks efficiently with features like task addition, deletion, and editing, as well as separating completed tasks from pending ones.

All user authentication (login & sign up) is powered by **Firebase Authentication**, and tasks are stored and synced in **Firebase Realtime Database**.

---

## Features

- **Authentication**
    - Login and Sign Up using Firebase Auth
    - Persistent user sessions

- **Todo Lists**
    - Three separate implementations using **Provider**, **GetX**, and **Cubit**
    - Add, edit, and delete tasks
    - Mark tasks as completed or pending
    - Real-time synchronization with Firebase Realtime Database

- **UI/UX**
    - Clean and responsive Flutter UI
    - Consistent design across all three state management methods

---

## Screens

1. **Welcome Screen** – Entry point for the app
2. **Login Screen** – Login using Firebase Authentication
3. **Sign Up Screen** – Create new account with Firebase Auth
4. **Todo Lists** – Three implementations:
    - Provider Todo List
    - GetX Todo List
    - Cubit (Bloc) Todo List

---

## Tech Stack

- Flutter (Dart)
- State Management: **Provider**, **GetX**, **Cubit (Bloc)**
- Firebase Authentication
- Firebase Realtime Database

---

## Installation

1. Clone the repository:
```bash
git clone https://github.com/username/todoapp.git
