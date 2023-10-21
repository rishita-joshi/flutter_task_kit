import 'dart:convert';
import 'package:flutter_iterview_task/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/user_model.dart';

class ApiHandler {
  //get Method

  static Future<UserModel> callLocationDetails(String lat, String long) async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(response.body);
      UserModel list = UserModel.fromJson(parsed);
      return list;
    } else {
      throw Exception('Failed to load Data');
    }
  }
  //Post Method

  Future<void> postData(String token) async {
    final url = Uri.parse(baseUrl); // Replace with your API endpoint.
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'key1': 'value1',
        'key2': 'value2',
      }),
    );

    if (response.statusCode == 200) {
      print('POST request successful. Response data: ${response.body}');
    } else {
      print('POST request failed. Status code: ${response.statusCode}');
    }
  }

  //Multipart method

//   void makeMultipartRequestWithToken(
//       String authToken, UserModel userModel) async {
//     // Create a multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

//     // Add headers, including the authorization token
//     request.headers['Authorization'] = 'Bearer $authToken';

//     // Add form fields (if needed)

//     request.fields['field1'] = 'value1';
//     request.fields['field2'] = 'value2';

//     // Add files
//     request.files.add(
//       http.MultipartFile(
//         'file',
//         // Provide a File object or a file path
//         'path_to_file.jpg',
//         // Set the content type (adjust it according to the file type)
//         'image/jpeg',
//       ),
//     );

//     try {
//       final response = await request.send();

//       if (response.statusCode == 200) {
//         print('Request sent successfully.');
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

  //patch method

  Future<void> sendPatchRequest() async {
    // Replace with your API endpoint and token
    final String apiUrl = 'https://your-api-endpoint.com/your-resource';
    final String authToken = 'your-authentication-token';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    final Map<String, dynamic> dataToUpdate = {
      'key1': 'new_value1',
      'key2': 'new_value2',
      // Add more fields to update as needed
    };

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(dataToUpdate),
      );

      if (response.statusCode == 200) {
        // PATCH request was successful
        print('PATCH request successful');
      } else {
        // Handle error - You can display an error message or perform other actions
        print('PATCH request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions, e.g., network issues
      print('An error occurred: $e');
    }
  }
}
