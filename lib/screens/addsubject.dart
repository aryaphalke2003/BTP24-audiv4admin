// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AddSubject extends StatefulWidget {
//   @override
//   _AddSubjectState createState() => _AddSubjectState();
// }

// class _AddSubjectState extends State<AddSubject> {
//   String selectedGrade = '1'; // Default selected grade
//   String selectedSubject = ''; // Default selected subject
//   List<String> grades = ['1', '2']; // List to store fetched grades
//   String? errorMessage;
//   String? classDropDown; // Updated to allow null
//   bool classDone = false;

//   List<String>? classOptions = ['1','2','3'];
//   // Updated to allow null

//   @override
//   void initState() {
//     super.initState();
//     // Fetch class options when the screen is initialized
//     fetchClassOptions();
//   }

//   Future<void> fetchClassOptions() async {
//     // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint to fetch class options
//     // try {
//     //   var response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

//     //   if (response.statusCode == 200) {
//     //     // If the API call is successful, parse the response and update the state
//     //     setState(() {
//     //       classOptions = List<String>.from(response.body);
//     //       classDropDown = classOptions?.isNotEmpty ?? false ? classOptions![0] : null;
//     //     });
//     //   } else {
//     //     // If the API call fails, set an error message
//     //     setState(() {
//     //       errorMessage = 'Failed to fetch class options. Please try again.';
//     //     });
//     //   }
//     // } catch (error) {
//     //   // Handle any exceptions that may occur during the API call
//     //   setState(() {
//     //     errorMessage = 'An error occurred. Please try again later.';
//     //   });
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Subject'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             classOptions == null || classOptions!.isEmpty
//                 ? Text(
//                     'No grades exist',
//                     style: TextStyle(color: Colors.red),
//                   )
//                 : DropdownButton<String>(
//                     // Choosing class
//                     isExpanded: true,
//                     value: classDropDown,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     items: classOptions?.map<DropdownMenuItem<String>>((String items) {
//                       return DropdownMenuItem<String>(
//                         value: items,
//                         child: Text(
//                           items,
//                           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//                         ),
//                       );
//                     }).toList() ?? [],
//                     onChanged: (String? newValue) {
//                       // stores the class selected.
//                       setState(() {
//                         classDropDown = newValue!;
//                         classDone = true;
//                       });
//                     },
//                   ),
//             const SizedBox(height: 20.0),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   selectedSubject = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Subject',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 bool subjectAlreadyExists =
//                     await subjectExists(selectedSubject);

//                 if (subjectAlreadyExists) {
//                   setState(() {
//                     errorMessage = 'Subject already exists.';
//                   });
//                   return;
//                 } else {
//                   // Proceed with your logic for saving the subject
//                   print('Selected Grade: $selectedGrade');
//                   print('Selected Subject: $selectedSubject');
//                   Navigator.pop(context); // Close the AddSubject screen
//                 }
//               },
//               child: Text('Save Subject'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool> subjectExists(String subject) async {
//     // Implement your logic to check if the subject exists on the server
//     // For now, we return false as a placeholder
//     return false;
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audiadmin/common_app_drawer.dart'; // Import CommonAppBarDrawer

class AddSubject extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  String selectedGrade = '1'; // Default selected grade
  String selectedSubject = ''; // Default selected subject
  List<String> grades = ['1', '2']; // List to store fetched grades
  String? errorMessage;
  String? classDropDown; // Updated to allow null
  bool classDone = false;

  List<String>? classOptions = ['1', '2', '3'];
  // Updated to allow null

  @override
  void initState() {
    super.initState();
    // Fetch class options when the screen is initialized
    fetchClassOptions();
  }

  Future<void> fetchClassOptions() async {
    // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint to fetch class options
    // try {
    //   var response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

    //   if (response.statusCode == 200) {
    //     // If the API call is successful, parse the response and update the state
    //     setState(() {
    //       classOptions = List<String>.from(response.body);
    //       classDropDown = classOptions?.isNotEmpty ?? false ? classOptions![0] : null;
    //     });
    //   } else {
    //     // If the API call fails, set an error message
    //     setState(() {
    //       errorMessage = 'Failed to fetch class options. Please try again.';
    //     });
    //   }
    // } catch (error) {
    //   // Handle any exceptions that may occur during the API call
    //   setState(() {
    //     errorMessage = 'An error occurred. Please try again later.';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBarDrawer( // Wrap your screen with CommonAppBarDrawer
      title: 'Add Subject',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            classOptions == null || classOptions!.isEmpty
                ? Text(
                    'No grades exist',
                    style: TextStyle(color: Colors.red),
                  )
                : DropdownButton<String>(
                    // Choosing class
                    isExpanded: true,
                    value: classDropDown,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: classOptions?.map<DropdownMenuItem<String>>((String items) {
                      return DropdownMenuItem<String>(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      );
                    }).toList() ?? [],
                    onChanged: (String? newValue) {
                      // stores the class selected.
                      setState(() {
                        classDropDown = newValue!;
                        classDone = true;
                      });
                    },
                  ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool subjectAlreadyExists =
                    await subjectExists(selectedSubject);

                if (subjectAlreadyExists) {
                  setState(() {
                    errorMessage = 'Subject already exists.';
                  });
                  return;
                } else {
                  // Proceed with your logic for saving the subject
                  print('Selected Grade: $selectedGrade');
                  print('Selected Subject: $selectedSubject');
                  Navigator.pop(context); // Close the AddSubject screen
                }
              },
              child: Text('Save Subject'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> subjectExists(String subject) async {
    // Implement your logic to check if the subject exists on the server
    // For now, we return false as a placeholder
    return false;
  }
}
