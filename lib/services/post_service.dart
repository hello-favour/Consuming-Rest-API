import 'dart:convert';

import 'package:consuming_rest_api/models/api_response.dart';
import 'package:consuming_rest_api/models/post_data.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const API = 'https://jsonplaceholder.typicode.com';

  final headers = {"Content-Type": "application/json"};

  Future<APIResponse<List<PostData>>> getNotesList() {
    return http.get(Uri.parse('$API/posts'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body) as List;
        final posts = jsonData.map((item) => PostData.fromJson(item)).toList();
        return APIResponse<List<PostData>>(data: posts);
      }
      return APIResponse<List<PostData>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) => APIResponse<List<PostData>>(
        error: true, errorMessage: "An error occurred"));
  }
}
