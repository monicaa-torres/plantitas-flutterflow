import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Plantss2FirebaseUser {
  Plantss2FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Plantss2FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Plantss2FirebaseUser> plantss2FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Plantss2FirebaseUser>(
            (user) => currentUser = Plantss2FirebaseUser(user));
