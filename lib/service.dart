import 'dart:convert';

import 'package:infinite_list2/comment.dart';
import 'package:http/http.dart' as http;

Future<List<Comment>> getCommentFormAPI(int start, int limit) async {
  final url =
      "https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit";
  final http.Client httpClient = http.Client();

  try {
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      late final List<Comment> comments = responseData.map(
        (e) {
          return Comment(
              id: e['id'], name: e['name'], body: e['body'], email: e['email']);
        },
      ).toList();
      print("hello");
      return comments; 
    }
  } catch (exception) {
    
  }

  return <Comment>[];
}
