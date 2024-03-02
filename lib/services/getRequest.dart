import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  Future<List> getpendingRequest() async {
    var url =
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/notapproved/');
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
    var url =
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/disapproved/');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print("disapproved data ${data}");
    return data;
    // return [
    //   {
    //     'id': 76,
    //     'Publish': '2024-02-18T13:42:59.617396Z',
    //     'Class': '9',
    //     'Subject': 'Maths',
    //     'ChapterName': 'Number_Systems',
    //     'PDF': null,
    //     'AudioFile': null,
    //     'is_approved': false,
    //     'author': 'Arya',
    //     'organization': 'IIT',
    //   },
    //   {
    //     'id': 76,
    //     'Publish': '2024-02-18T13:42:59.617396Z',
    //     'Class': '9',
    //     'Subject': 'Maths',
    //     'ChapterName': 'Number_Systems',
    //     'PDF': null,
    //     'AudioFile': null,
    //     'is_approved': false,
    //     'author': 'Arya',
    //     'organization': 'IIT',
    //   }
    // ];

    //   return [
    //     {
    //       "id": 1,
    //       "Publish": "2023-03-14T20:41:53.772000Z",
    //       "Class": "",
    //       "Subject": "Maths",
    //       "ChapterName": "9_Number_Systems",
    //       "PDF":
    //           "https://drive.google.com/uc?id=1GCiwlA4-TuxeoR6jJga5AJEvWgag2eFU&export=download",
    //       "AudioFile":
    //           "https://drive.google.com/uc?id=1v413ogIp8SiglWYfoZy1sXfKYUiuoaB2&export=download",
    //       "is_approved": true,
    //       "Author": "",
    //       "description": "",
    //       "References": "",
    //       "is_disapproved": false,
    //       "approvedBy": null
    //     },
    //     {
    //       "id": 67,
    //       "Publish": "2024-02-15T18:37:27.950838Z",
    //       "Class": "",
    //       "Subject": "",
    //       "ChapterName": "",
    //       "PDF": null,
    //       "AudioFile":
    //           "https://drive.google.com/uc?id=1clDmyQlcmbICwIBuaAynYScd_Pe8loqy&export=download",
    //       "is_approved": true,
    //       "Author": "",
    //       "description": "",
    //       "References": "",
    //       "is_disapproved": false,
    //       "approvedBy": null
    //     }
    //   ];
  }

  Future<List> getapprovedRequest() async {
    // var url =
    //     Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/approved/');
    // var response = await http.get(url);
    // var data = jsonDecode(response.body);
    // print("approved data ${data}");
    // return data;

    return [
      {
        'id': 76,
        'Publish': '2024-02-18T13:42:59.617396Z',
        'Class': '9',
        'Subject': 'Maths',
        'ChapterName': 'Number_Systems',
        'PDF': null,
        'AudioFile': null,
        'is_approved': false,
        'author': 'Arya',
        'organization': 'IIT',
      },
      {
        'id': 77,
        'Publish': '2024-03-18T13:42:59.617396Z',
        'Class': '9',
        'Subject': 'Maths',
        'ChapterName': 'Number_Systems',
        'PDF':
            'https://drive.google.com/uc?id=1OKQ9L9IYZjYpv7iNced7MT98tz0Benzh&export=download',
        'AudioFile':
            'https://drive.google.com/uc?id=1ZHxdlqUTxi4WCv9wVnlGMTaZUFlH7Zf0&export=download',
        'is_approved': false,
        'author': 'Arya',
        'organization': 'IIT',
      }
    ];
  }
}
