import 'package:flutter/material.dart';
import 'package:wikidados_teste/models/secureStorage.dart';

class UserAuth extends ChangeNotifier {
  // Persist Data
  SecureStorage storage = SecureStorage();

  Future<bool> isLogged() async {
    String? refreshToken = await storage.readString("refreshToken");

    // Check with the backend if the refreshToken is valid

    return refreshToken == null ? false : true;
  }

  bool login(String email, String password) {
    // Send email and password to the backend
    if (email == "luccagabriel12@hotmail.com" && password == "umaSenhaForte") {
      // If they are valid the backend respond with a token
      String token = "someTokenLogic";

      // Save the token
      storage.saveString("refreshToken", token);

      return true;
    }

    return false;
  }

  void logout() {
    storage.deleteKey("refreshToken");
    notifyListeners();
  }
}
