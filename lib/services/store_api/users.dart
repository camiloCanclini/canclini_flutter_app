import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService{
  static String apiUrl = dotenv.env['API_URL']!;

   Future<String> sendCredentials (String email, String pass) async {
     final Map<String, String> data = {
       'email': email,
       'password': pass,
     };

     final http.Response response = await http.post(
       Uri.parse(apiUrl),
       body: json.encode(data),
       headers: {'Content-Type': 'application/json'},
     );
     final Map<String, dynamic> responseData = json.decode(response.body);
     if (response.statusCode == 200){
       return responseData['apiKey'];
     } else {
       throw Exception('The was an error sending the credencials!');
     }
  }

}