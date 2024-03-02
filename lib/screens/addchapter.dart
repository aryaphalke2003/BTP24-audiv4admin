import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:audiadmin/common_app_drawer.dart'; // Import CommonAppBarDrawer
import 'package:http/http.dart' as http;

class AddChapter extends StatefulWidget {
  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
  String selectedChapter = '';
  int selectedGrade = 0; // Default selected grade
  String selectedSubject = ''; // Default selected subject
  List<int> grades = [];
  List<String> subjectOptions = [];
  String? errorMessage;
  TextEditingController chapterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch grades when the screen is initialized
    fetchGrades();
  }

  Future<void> fetchGrades() async {
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/fetch-data/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': 'fetchgrades',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> gradesData = jsonDecode(response.body);

        setState(() {
          grades =
              gradesData.map<int>((grade) => grade['grade'] as int).toList();
          grades.sort();
          selectedGrade = grades.isNotEmpty ? grades[0] : 0;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch grades. Please try again.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  Future<void> fillup(int grade) async {
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/fetch-data/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': 'fetchsubjects',
          'grade': grade,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> subdata = jsonDecode(response.body);

        setState(() {
          // Assuming subjectsDataList is a List<Map<String, dynamic>>
          subjectOptions = subdata
              .map<String>((subject) => subject['subjectname'] as String)
              .toList();
          selectedSubject = subjectOptions.isNotEmpty ? subjectOptions[0] : '';
          print("subops: ${subjectOptions}");
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch subjects. Please try again.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  Future<Response> AddChapterFunc(int grade, String subject, String chapter) async {
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/add-data/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': 'chapter',
          'grade': grade,
          'subject': subject,
          'chapter': chapter,
        }),
      );

      return response;
    } catch (error) {
      // An error occurred during the HTTP request
      throw Exception('An error occurred. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBarDrawer(
      // Wrap your screen with CommonAppBarDrawer
      title: 'Add Chapter',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Select Grade:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 8.0),
            grades.isEmpty
                ? Text(
                    'No grades exist',
                    style: TextStyle(color: Colors.red),
                  )
                : DropdownButton<int>(
                    // Choosing grade
                    isExpanded: true,
                    value: selectedGrade,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: grades.map<DropdownMenuItem<int>>((int grade) {
                      return DropdownMenuItem<int>(
                        value: grade,
                        child: Text(
                          grade.toString(),
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedGrade = newValue ?? 0;
                        fillup(selectedGrade);
                      });
                    },
                  ),
            const SizedBox(height: 20.0),

            //sub
            Container(
              child: Text(
                'Select Subject:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 8.0),
            subjectOptions.isEmpty
                ? Text(
                    'No subject exist',
                    style: TextStyle(color: Colors.red),
                  )
                : DropdownButton<String>(
                    // Choosing grade
                    isExpanded: true,
                    value: selectedSubject,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: subjectOptions
                        .map<DropdownMenuItem<String>>((String chapter) {
                      return DropdownMenuItem<String>(
                        value: chapter,
                        child: Text(
                          chapter,
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubject = newValue ?? '';
                      });
                    },
                  ),
            const SizedBox(height: 20.0),

            //chapter

            TextField(
              controller: chapterController,
              decoration: InputDecoration(
                labelText: 'Enter Chapter',
                errorText: errorMessage,
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                selectedChapter = chapterController.text;

                if (selectedChapter.isEmpty) {
                  setState(() {
                    errorMessage = 'Chapter name is required.';
                  });
                  return;
                }

                print('Selected Grade: $selectedGrade');
                print('Selected Subject: $selectedSubject');
                print('Selected Subject: $selectedChapter');

                var resp = await AddChapterFunc(
                    selectedGrade, selectedSubject, selectedChapter);

                if (resp.statusCode == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text('Chapter ${selectedChapter} Added Successfully!'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ));
                  Navigator.pop(context);
                } else {
                  setState(() {
                    errorMessage = "Error occured try again!";
                    print('error: $errorMessage');
                  });
                  return;
                }
              },
              child: Text('Save Chapter'),
            ),
          ],
        ),
      ),
    );
  }
}
