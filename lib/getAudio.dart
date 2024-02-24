import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore_for_file: slash_for_doc_comments

/**
 * The file is responsible for fetching the audiobooks from the django server.
 * On the server, different json links are generated from where we can 
 * direclty fetch the audiobooks using POST and GET request. If the request is 
 * successful and some valid data is returned, then the data is decoded and returned,
 * as it is fetched in json format.
 */
class Audios {
  String base_url = "https://arya09.pythonanywhere.com/audiofiles/audiofiles/";

  // This function returns all audios without any applied filter.
  Future<List> getAudio() async {
    // try {
    var result = await http.get(Uri.parse(base_url));
    // print(result.statusCode);
    if (result.statusCode == 200) {
      var k = jsonDecode(result.body);
      print(k);
      return k;
    } else {
      return Future.error("Server Error");
    }
  }

  /// The function returns all the audios for a particular chapter.
  Future<List> selectedAudio(className, chapterName, subjectName) async {
    try {
      print("indgetaudio");
      String base_url = "http://127.0.0.1:8000/audiofiles/audiofiles/";

   
        var result = await http.post(
          Uri.parse(base_url),
          body: {
            'Class': className,
            'ChapterName': chapterName,
            'Subject': subjectName,
          },
        );

        
      if (result.statusCode == 200) {
        var k = jsonDecode(result.body);
        if (k.length == 0) {
          return Future.error("No Audio Available");
        }
        var new_result = [];
        new_result.add(k[0]);
        print("returning this: ${new_result}");

        return new_result;
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      print("jiji");

      return Future.error(e);
    }
  }
}
