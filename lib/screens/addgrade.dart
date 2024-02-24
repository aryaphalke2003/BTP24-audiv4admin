// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AddGrade extends StatefulWidget {
//   @override
//   _AddGradeState createState() => _AddGradeState();
// }

// class _AddGradeState extends State<AddGrade> {
//   TextEditingController gradeController = TextEditingController();
//   String? errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Grade'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: gradeController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter Grade',
//                 errorText: errorMessage,
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 String enteredGrade = gradeController.text;

//                 if (!validateGrade(enteredGrade)) {
//                   setState(() {
//                     errorMessage =
//                         'Invalid grade. Please enter a number between 1 and 12.';
//                   });
//                   return;
//                 }

//                  bool itexist = await gradeExists(enteredGrade);

//                 if (!itexist) {
//                   setState(() {
//                     errorMessage = 'Grade already exists.';
//                   });
//                   return;
//                 } else {
//                   // Proceed with your logic for saving the grade
//                   print('Entered Grade: $enteredGrade');
//                   Navigator.pop(context); // Close the AddGrade screen
//                 }
//               },
//               child: Text('Save Grade'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool validateGrade(String grade) {
//     // Check if grade is numeric
//     if (double.tryParse(grade) == null) {
//       return false;
//     }

//     // Check if grade is within the range of 1 to 12
//     int numericGrade = int.parse(grade);
//     return numericGrade >= 1 && numericGrade <= 12;
//   }

//   Future<bool> gradeExists(String grade) async {
//     // final response =
//     //     await http.get(Uri.parse('http://localhost:6000/grades/$grade'));

//     // if (response.statusCode == 200) {
//     //   // Grade exists
//     //   return true;
//     // } else if (response.statusCode == 404) {
//     //   // Grade does not exist
//     //   return false;
//     // } else {
//     //   // Handle other status codes as needed
//     //   return false;
//     // }
//     return false;
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audiadmin/common_app_drawer.dart'; // Import CommonAppBarDrawer

class AddGrade extends StatefulWidget {
  @override
  _AddGradeState createState() => _AddGradeState();
}

class _AddGradeState extends State<AddGrade> {

  TextEditingController gradeController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return CommonAppBarDrawer( // Wrap your screen with CommonAppBarDrawer
      title: 'Add Grade',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: gradeController,
              keyboardType: TextInputType.number,
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
                        'Invalid grade. Please enter a number between 1 and 12.';
                  });
                  return;
                }

                bool itexist = await gradeExists(enteredGrade);

                if (!itexist) {
                  setState(() {
                    errorMessage = 'Grade already exists.';
                  });
                  return;
                } else {
                  // Proceed with your logic for saving the grade
                  print('Entered Grade: $enteredGrade');
                  Navigator.pop(context); // Close the AddGrade screen
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
    // Check if grade is numeric
    if (double.tryParse(grade) == null) {
      return false;
    }

    // Check if grade is within the range of 1 to 12
    int numericGrade = int.parse(grade);
    return numericGrade >= 1 && numericGrade <= 12;
  }

  Future<bool> gradeExists(String grade) async {
    // Implement your logic to check if the grade exists
    return false;
  }
}

