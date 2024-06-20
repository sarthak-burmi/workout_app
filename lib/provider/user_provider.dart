import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:workout_app/adapter/userAdapter.dart';
import 'package:workout_app/model/user_modal.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  late Box<User> _userBox;
  final Completer<void> _boxCompleter = Completer<void>();

  User? get user => _user;
  User? _currentUser;
  User? get currentUser => _currentUser;

  UserProvider() {
    _init();
  }

  Future<void> _init() async {
    await _openBox();
    await loadUser();
  }

  Future<void> _openBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    _userBox = await Hive.openBox<User>('users');
    _boxCompleter.complete();
  }

  Future<void> loadUser() async {
    await _ensureBoxIsReady();
    if (_userBox.isNotEmpty) {
      _user = _userBox.getAt(0)!;
    } else {
      _user = User(
        name: 'Default',
        email: '',
        number: '',
        age: 0,
        height: 0,
        weight: 0,
        sex: '',
        completedExercises: [],
        enableBackgroundMusic: true,
      );
      await _userBox.add(_user!);
    }
    _currentUser = _user;
    notifyListeners();
  }

  Future<void> _ensureBoxIsReady() async {
    if (!_boxCompleter.isCompleted) {
      await _boxCompleter.future;
    }
  }

  void addUser(User user) async {
    await _ensureBoxIsReady();
    await _userBox.add(user);
    _user = user;
    _currentUser = _user;
    notifyListeners();
  }

  void updateUser(User user) async {
    await _ensureBoxIsReady();
    await _userBox.putAt(0, user);
    _user = user;
    _currentUser = _user;
    notifyListeners();
  }

  void completeExercise(String exerciseName) {
    if (_user != null) {
      _user!.addCompletedExercise(exerciseName);
      _userBox.putAt(0, _user!);
      notifyListeners();
    }
  }

  bool isExerciseCompleted(String exerciseName) {
    return _user != null && _user!.isExerciseCompleted(exerciseName);
  }

  void toggleBackgroundMusic(bool value) {
    if (_user != null) {
      _user!.enableBackgroundMusic = value;
      _userBox.putAt(0, _user!);
      notifyListeners();
    }
  }
}
