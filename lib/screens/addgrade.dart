import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../pending_req.dart';
import 'package:audiadmin/common_app_drawer.dart';

class AddGrade extends StatefulWidget {
  @override
  _AddGradeState createState() => _AddGradeState();
}

class _AddGradeState extends State<AddGrade> {
  TextEditingController gradeController = TextEditingController();
  String? errorMessage;
  List<int> existingGrades = []; // List to store existing grades

  @override
  void initState() {
    super.initState();
    fetchExistingGrades(); // Fetch existing grades when the page is initialized
  }

  // Function to fetch existing grades
  Future<void> fetchExistingGrades() async {
    final response = await http.post(
      Uri.parse(
          'https://arya09.pythonanywhere.com/audiofiles/audiofiles/fetch-data/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': 'fetchgrades',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> fetchedGrades = jsonDecode(response.body);
      setState(() {
        existingGrades =
            fetchedGrades.map<int>((grade) => grade['grade']).toList();
        existingGrades.sort();
      });
    } else {
      throw Exception('Failed to fetch existing grades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBarDrawer(
      title: 'Add Grade',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        
        
        
        
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display existing grades
            Text('Existing Grades: ${existingGrades.join(', ')}'),
            SizedBox(height: 20),
            TextField(
              controller: gradeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Enter Grade',
                errorText: errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String enteredGrade = gradeController.text;

                if (!validateGrade(enteredGrade)) {
                  setState(() {
                    errorMessage =
                        'Invalid grade. Please enter a number between 6 and 12.';
                  });
                  return;
                }

                if (existingGrades.contains(int.parse(enteredGrade))) {
                  setState(() {
                    errorMessage = 'Grade $enteredGrade already exists.';
                  });
                  return;
                } else {
                  print('Entered Grade: $enteredGrade');

                  bool saved = await saveGrade(int.parse(enteredGrade));

                  if (saved) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text('Grade Added Successfully!'),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingRequestPage()),
                    );
                    
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text('Grade Addition Failed!'),
                        ],
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ));
                  }

                  // Close the AddGrade screen
                  return;
                }
              },
              child: Text('Save Grade'),
            ),
          ],
        ),









        
      ),
    );
  }

  bool validateGrade(String grade) {
    int numericGrade = int.tryParse(grade) ?? 0;
    return numericGrade >= 6 && numericGrade <= 12;
  }

  Future<bool> saveGrade(int grade) async {
    final response = await http.post(
      Uri.parse(
          'https://arya09.pythonanywhere.com/audiofiles/audiofiles/add-data/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': 'grade',
        'grade': grade,
      }),
    );

    return response.statusCode == 201;
  }
}
