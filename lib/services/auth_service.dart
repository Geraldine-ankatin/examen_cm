import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken ='AIzaSyAiD1lJoB5Y_AgRivCwrzlbdZM1QCP_uLE';
  // final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';
  String? _token = ''; 
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      _token = decodeResponse['idToken']; 
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future<String?> create_user(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    print(authData);
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      _token = decodeResponse['idToken']; 
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }
  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); 
  }
}
