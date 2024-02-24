// // import 'package:flutter/material.dart';

// // class AddChapter extends StatefulWidget {
// //   @override
// //   _AddChapterState createState() => _AddChapterState();
// // }

// // class _AddChapterState extends State<AddChapter> {
// //   String? classDropDown; // Updated to allow null
// //   bool classDone = false;
// //   String? subjectDropDown; // Updated to allow null
// //   bool subjectDone = false;
// //   String selectedChapter = ''; // Default selected chapter
// //   List<String>? classOptions = ['Class 1', 'Class 2', 'Class 3']; // Replace with API data
// //   List<String>? subjectOptions = ['Subject A', 'Subject B', 'Subject C']; // Replace with API data
// //   String? errorMessage;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Add Chapter'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             classOptions == null || classOptions!.isEmpty
// //                 ? Text(
// //                     'No classes exist',
// //                     style: TextStyle(color: Colors.red),
// //                   )
// //                 : DropdownButton<String>(
// //                     // Choosing class
// //                     isExpanded: true,
// //                     value: classDropDown,
// //                     icon: const Icon(Icons.keyboard_arrow_down),
// //                     items: classOptions?.map<DropdownMenuItem<String>>((String items) {
// //                       return DropdownMenuItem<String>(
// //                         value: items,
// //                         child: Text(
// //                           items,
// //                           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
// //                         ),
// //                       );
// //                     }).toList() ?? [],
// //                     onChanged: (String? newValue) {
// //                       // stores the class selected.
// //                       setState(() {
// //                         classDropDown = newValue!;
// //                         classDone = true;
// //                       });
// //                     },
// //                   ),
// //             const SizedBox(height: 20.0),
// //             subjectOptions == null || subjectOptions!.isEmpty
// //                 ? Text(
// //                     'No subjects exist',
// //                     style: TextStyle(color: Colors.red),
// //                   )
// //                 : DropdownButton<String>(
// //                     // Choosing subject
// //                     isExpanded: true,
// //                     value: subjectDropDown,
// //                     icon: const Icon(Icons.keyboard_arrow_down),
// //                     items: subjectOptions?.map<DropdownMenuItem<String>>((String items) {
// //                       return DropdownMenuItem<String>(
// //                         value: items,
// //                         child: Text(
// //                           items,
// //                           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
// //                         ),
// //                       );
// //                     }).toList() ?? [],
// //                     onChanged: (String? newValue) {
// //                       // storing the chosen subject
// //                       setState(() {
// //                         subjectDropDown = newValue!;
// //                         subjectDone = true;
// //                       });
// //                     },
// //                   ),
// //             const SizedBox(height: 20.0),
// //             TextField(
// //               onChanged: (value) {
// //                 setState(() {
// //                   selectedChapter = value;
// //                 });
// //               },
// //               decoration: InputDecoration(
// //                 labelText: 'Chapter Name',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 if (!classDone || !subjectDone) {
// //                   // Check if class and subject are selected
// //                   setState(() {
// //                     errorMessage = 'Please select class and subject.';
// //                   });
// //                   return;
// //                 }

// //                 // Proceed with your logic for saving the chapter
// //                 print('Selected Class: $classDropDown');
// //                 print('Selected Subject: $subjectDropDown');
// //                 print('Selected Chapter: $selectedChapter');
// //                 Navigator.pop(context); // Close the AddChapter screen
// //               },
// //               child: Text('Save Chapter'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class AddChapter extends StatefulWidget {
//   @override
//   _AddChapterState createState() => _AddChapterState();
// }

// class _AddChapterState extends State<AddChapter> {
//   String? classDropDown;
//   bool classDone = false;
//   String? subjectDropDown;
//   bool subjectDone = false;
//   String selectedChapter = '';
//   List<String>? classOptions = ['Class 1', 'Class 2', 'Class 3'];
//   List<String>? subjectOptions = ['Subject A', 'Subject B', 'Subject C'];
//   String? errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Chapter'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             buildDropdown(
//               label: 'Choose Class',
//               value: classDropDown,
//               items: classOptions,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   classDropDown = newValue!;
//                   classDone = true;
//                 });
//               },
//             ),
//             const SizedBox(height: 20.0),
//             buildDropdown(
//               label: 'Choose Subject',
//               value: subjectDropDown,
//               items: subjectOptions,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   subjectDropDown = newValue!;
//                   subjectDone = true;
//                 });
//               },
//             ),
//             const SizedBox(height: 20.0),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   selectedChapter = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Chapter Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (!classDone || !subjectDone) {
//                   setState(() {
//                     errorMessage = 'Please select class and subject.';
//                   });
//                   return;
//                 }

//                 if (selectedChapter.isEmpty) {
//                   setState(() {
//                     errorMessage = 'Chapter name cannot be empty.';
//                   });
//                   return;
//                 }

//                 // Proceed with your logic for saving the chapter
//                 print('Selected Class: $classDropDown');
//                 print('Selected Subject: $subjectDropDown');
//                 print('Selected Chapter: $selectedChapter');
//                 Navigator.pop(context); // Close the AddChapter screen
//               },
//               child: Text('Save Chapter'),
//             ),
//             if (errorMessage != null)
//               Text(
//                 errorMessage!,
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String label,
//     required String? value,
//     required List<String>? items,
//     required void Function(String?) onChanged,
//   }) {
//     return items == null || items.isEmpty
//         ? Text(
//             'No $label exist',
//             style: TextStyle(color: Colors.red),
//           )
//         : DropdownButton<String>(
//             isExpanded: true,
//             value: value,
//             icon: const Icon(Icons.keyboard_arrow_down),
//             items: items.map<DropdownMenuItem<String>>((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//                 ),
//               );
//             }).toList(),
//             onChanged: onChanged,
//           );
//   }
// }


import 'package:flutter/material.dart';
import 'package:audiadmin/common_app_drawer.dart'; // Import CommonAppBarDrawer



class AddChapter extends StatefulWidget {
  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {


  String? classDropDown;
  bool classDone = false;
  String? subjectDropDown;
  bool subjectDone = false;
  String selectedChapter = '';
  List<String>? classOptions = ['Class 1', 'Class 2', 'Class 3'];
  List<String>? subjectOptions = ['Subject A', 'Subject B', 'Subject C'];
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return CommonAppBarDrawer( // Wrap your screen with CommonAppBarDrawer
      title: 'Add Chapter',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDropdown(
              label: 'Choose Class',
              value: classDropDown,
              items: classOptions,
              onChanged: (String? newValue) {
                setState(() {
                  classDropDown = newValue!;
                  classDone = true;
                });
              },
            ),
            const SizedBox(height: 20.0),
            buildDropdown(
              label: 'Choose Subject',
              value: subjectDropDown,
              items: subjectOptions,
              onChanged: (String? newValue) {
                setState(() {
                  subjectDropDown = newValue!;
                  subjectDone = true;
                });
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  selectedChapter = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Chapter Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!classDone || !subjectDone) {
                  setState(() {
                    errorMessage = 'Please select class and subject.';
                  });
                  return;
                }

                if (selectedChapter.isEmpty) {
                  setState(() {
                    errorMessage = 'Chapter name cannot be empty.';
                  });
                  return;
                }

                // Proceed with your logic for saving the chapter
                print('Selected Class: $classDropDown');
                print('Selected Subject: $subjectDropDown');
                print('Selected Chapter: $selectedChapter');
                Navigator.pop(context); // Close the AddChapter screen
              },
              child: Text('Save Chapter'),
            ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String>? items,
    required void Function(String?) onChanged,
  }) {
    return items == null || items.isEmpty
        ? Text(
            'No $label exist',
            style: TextStyle(color: Colors.red),
          )
        : DropdownButton<String>(
            isExpanded: true,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          );
  }
}

