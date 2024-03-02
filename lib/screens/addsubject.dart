import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audiadmin/common_app_drawer.dart';
import 'package:http/http.dart';

class AddSubject extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  int selectedGrade = 0; // Default selected grade
  String selectedSubject = ''; // Default selected subject
  List<int> grades = [];
  String? errorMessage;
  TextEditingController subjectController = TextEditingController();


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
        final List<dynamic> gradeDataList = jsonDecode(response.body);

        setState(() {
          grades =
              gradeDataList.map<int>((grade) => grade['grade'] as int).toList();
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

  Future<Response> AddSubjectFunc(int grade, String subject) async {
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/audiofiles/audiofiles/add-data/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': 'subject',
          'grade': grade,
          'subject': subject,
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
      title: 'Add Subject',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title above the DropdownButton
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
                      });
                    },
                  ),
            const SizedBox(height: 20.0),

            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Enter Subject',
                errorText: errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                selectedSubject = subjectController.text;
                
                if (selectedSubject.isEmpty) {
                  
                  setState(() {
                    errorMessage = 'Subject name is required.';
                  });
                  return;
                }

                print('Selected Grade: $selectedGrade');
                print('Selected Subject: $selectedSubject');

                var resp = await AddSubjectFunc(selectedGrade, selectedSubject);

                if (resp.statusCode == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text('Subject $selectedSubject Added Successfully!'),
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
              child: Text('Save Subject'),
            ),
          ],
        ),
      ),
    );
  }
}
