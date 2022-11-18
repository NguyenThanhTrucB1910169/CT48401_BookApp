import 'dart:convert';
import 'dart:async';
import 'firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/http_exception.dart';
import '../models/auth_token.dart';

class AuthService extends FirebaseService {
  static const _authTokenKey = 'authToken';
  late final String? _apiKey;

  AuthService() {
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';
  }

  Future<AuthToken> _authenticate(
      String email, String password, String method) async {
    try {
      final url = Uri.parse(_buildAuthUrl(method));
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {
        throw HttpException.firebase(responseJson['error']['message']);
      }

      final authToken = _fromJson(responseJson);
      _saveAuthToken(authToken);

      return authToken;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<AuthToken> signup(String email, String password) {
    return _authenticate(email, password, 'signUp');
  }

  Future<AuthToken> login(String email, String password) {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['idToken'],
      userId: json['localId'],
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(
            json['expiresIn'],
          ),
        ),
      ),
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }

    final savedToken = prefs.getString(_authTokenKey);

    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (!authToken.isValid) {
      return null;
    }
    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }

  Future<List<AuthToken>> fetchAdmin() async {
    final List<AuthToken> admins = [];
    try {
      final adminsUrl = Uri.parse('$databaseUrl/admins.json?auth=$token');
      final response = await http.get(adminsUrl);
      final adminsMap = json.decode(response.body) as Map<String, dynamic>;
      // print(productsMap);
      if (response.statusCode != 200) {
        return admins;
      }

      adminsMap.forEach((adminid, admin) {
        admins.add(AuthToken.fromJson(admin));
      });
      // print(products);
      return admins;
    } catch (error) {
      print(error);
      return admins;
    }
  }
}
