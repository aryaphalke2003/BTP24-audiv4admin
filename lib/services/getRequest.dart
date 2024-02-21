import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  Future<List> getRequest() async {
    // var url = Uri.parse('https://arya09.pythonanywhere.com/teacher/posts');
    // var response = await http.get(url);
    // var data = jsonDecode(response.body);
    // return data;
    return [
      {
        'id': 76,
        'Publish': '2024-02-18T13:42:59.617396Z',
        'Class': '9',
        'Subject': 'Maths',
        'ChapterName': 'NUMBER SYSTEM',
        'PDF': null,
        'AudioFile': null,
        'is_approved': false,
        'author': 'Arya',
        'organization': 'IIT',
      },
      {
        'id': 76,
        'Publish': '2024-02-18T13:42:59.617396Z',
        'Class': '9',
        'Subject': 'Maths',
        'ChapterName': 'NUMBER SYSTEM',
        'PDF': null,
        'AudioFile': null,
        'is_approved': false,
        'author': 'Arya',
        'organization': 'IIT',
      }
    ];
  }
}
