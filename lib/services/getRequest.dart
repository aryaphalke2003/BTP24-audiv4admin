import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  Future<List> getpendingRequest() async {
    var url = Uri.parse(
        'https://arya09.pythonanywhere.com/audiofiles/audiofiles/notapproved/');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print("pending data ${data}");
    return data;
    //   return [
    //     {
    //       'id': 76,
    //       'Publish': '2024-02-18T13:42:59.617396Z',
    //       'Class': '9',
    //       'Subject': 'Maths',
    //       'ChapterName': 'Number_Systems',
    //       'PDF': null,
    //       'AudioFile': null,
    //       'is_approved': false,
    //       'author': 'Arya',
    //       'organization': 'IIT',
    //     },
    //     {
    //       'id': 76,
    //       'Publish': '2024-02-18T13:42:59.617396Z',
    //       'Class': '9',
    //       'Subject': 'Maths',
    //       'ChapterName': 'Number_Systems',
    //       'PDF': null,
    //       'AudioFile': null,
    //       'is_approved': false,
    //       'author': 'Arya',
    //       'organization': 'IIT',
    //     }
    //   ];
  }

  Future<List> getdisapprovedRequest() async {
    var url = Uri.parse(
        'https://arya09.pythonanywhere.com/audiofiles/audiofiles/disapproved/');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print("disapproved data ${data}");
    return data;
  }

  Future<List> getapprovedRequest() async {
    var url = Uri.parse(
        'https://arya09.pythonanywhere.com/audiofiles/audiofiles/approved/');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print("approved data ${data}");
    return data;
  }
}
