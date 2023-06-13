import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user.dart';

//refresh url

const baseUrl = 'http://127.0.0.1:8000/';
// const baseUrl = 'http://192.168.100.48:8000/';
// const baseUrl = 'http://192.168.0.212:8000/';

// const baseUrl = 'http://192.168.100.30:8000/';
// const baseUrl = 'http://192.168.0.107:8000/';

const login = '$baseUrl/login_P/';
const signUpUrl = '$baseUrl/patient_rg/';
const refreshUrl = '$baseUrl/refresh/';

class AuthService {
  static String accessToken = '';
  static String refreshToken = '';
  static String id = '';

  static Future<UserModel> signIn(String phone, String password) async {
    final uri = Uri.parse(login);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone_number': phone, 'password': password}),
    );

    final data = jsonDecode(response.body);
    print('$data 22');
    accessToken = data['access'];
    id = data['id'].toString();

    if (response.statusCode == 200) {
      print('${response.body} signIn');
      final user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('Something went wrong');
    }
  }

  static Future<UserModel> signUp(
      String nni, String phone, String password) async {
    final uri = Uri.parse(signUpUrl);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'phone_number': phone,
          'nni': nni,
          'password': password,
        },
      ),
    );

    print(response.statusCode);
    final data = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      await AuthService.signIn(phone, password);
      final user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<String> refresh() async {
    final response = await http.post(
      Uri.parse(refreshUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );
    final data = jsonDecode(response.body);
    accessToken = data['access'];
    await saveTokens();
    return accessToken;
  }

  static Future<void> saveTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('id', id);
  }

  static Future<String> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';
    refreshToken = prefs.getString('refresh_token') ?? '';
    id = prefs.getString('id') ?? '';

    return refreshToken;
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('id');
  }

  static bool isAuthenticated() {
    if (accessToken.isNotEmpty && !JwtDecoder.isExpired(accessToken)) {
      return true;
    } else {
      return false;
    }
  }
}

class CentreRepo {
  Future<List<Centre>>? fetchCentreList() async {
    final response = await http.get(
      Uri.parse('$baseUrl/centres_rest/'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Centre> centres = jsonList.map((e) => Centre.fromJson(e)).toList();
      for (var i = 0; i < centres.length; i++) {
        print(centres[i].nom);
        print(centres[i].longitude);
        print(centres[i].latitude);
      }
      // print(centres);
      return centres;
    } else {
      throw Exception('Failed to load bank list');
    }
  }
}

class VaccinationRepo {
  static Future<Vaccination> getVaccines() async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }

    final response = await http.get(
      Uri.parse('$baseUrl/patient_DT/${AuthService.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('$data ==============');

      final vaccination = Vaccination.fromJson(data);

      print('$vaccination this is the user data helloooooo');

      await AuthService.saveTokens();
      return vaccination;
    } else {
      throw 'message';
    }
  }
}
