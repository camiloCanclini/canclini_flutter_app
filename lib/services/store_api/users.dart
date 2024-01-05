import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService{
  static String apiUrl = dotenv.env['API_URL']!;

   static Future<String> loginUser (String email, String pass) async {
     final Map<String, String> data = {
       'email': email,
       'password': pass,
     };

     try{
       final http.Response response = await http.post(
         Uri.parse('$apiUrl/login'),
         body: json.encode(data),
         headers: {'Content-Type': 'application/json'},
       ).timeout(const Duration(seconds: 15));

       if (response.statusCode == 200){
         final Map<String, dynamic> responseData = json.decode(response.body);
         return responseData['apiKey'];
       } else {
         throw Exception();
       }
     } catch (e){
       throw Exception('The was an error trying to logging the user!');
     }

  }

  static Future<String> registerUser (String email, String pass) async {
    final Map<String, String> data = {
      'email': email,
      'password': pass,
    };

    final http.Response response = await http.post(
      Uri.parse('$apiUrl/register'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 15));
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200){
      return responseData['apiKey'];
    } else {
      throw Exception('The was an error sending the credencials!');
    }
  }
}