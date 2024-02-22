// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'getAudio.dart';
// import '../shared/routes.dart';
// import 'package:dio/dio.dart';

// // ignore: slash_for_doc_comments
// /**
//  * Audiobook page has the option to download pdf as well.
//  * That functionality is added in this file. According to the chapter selected,
//  * and the objective, pdf are selected from the database. This is done by creating a 
//  * temp directory.
//  */
// class PDFViewer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Audios getAudio = Audios();
//     var stri = myStack.toString();
//     var arr = (stri.substring(1, stri.length - 1)).split(',');
//     print(arr);
//     String chapterName = arr[3];
//     String className = arr[1].split(" ")[2];
//     chapterName = chapterName.trim();
//     print(chapterName + className);
//     return Stack(children: [
//       FutureBuilder<List>(
//         future: getAudio.selectedAudio(className,chapterName),
//         builder: (context, snapshot) {
//           return (snapshot.hasData && snapshot.data!.isNotEmpty)
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     print(snapshot.data![snapshot.data!.length - index - 1]);
//                     return IconButton(
//                       onPressed: () async {
//                         var dio = Dio();
//                         // creating a temp directory
//                         var tempDir = await getTemporaryDirectory();
//                         String fullPath = tempDir.path + "/boo2.pdf'";
//                         print("pdf loaded");
//                         print('full path ${fullPath}');
//                         var imgUrl =
//                             snapshot.data![snapshot.data!.length - index - 1]
//                                 ['chapterPdf'];
//                         // getting required permissions
//                         //getPermissions();
//                         // displays the download progress
//                         download2(dio, imgUrl, fullPath);
//                       },
//                       icon: const Icon(
//                         Icons.download,
//                         color: Colors.white,
//                       ),
//                     );
//                   },
//                 )
//               : IconButton(
//                   onPressed: () async {
//                     var dio = Dio();
//                     var tempDir = await getTemporaryDirectory();
//                     String fullPath = tempDir.path + "/boo2.pdf'";
//                     print('full path ${fullPath}');
//                     var imgUrl =
//                         "http://www.africau.edu/images/default/sample.pdf";
//                     //getPermissions();
//                     download2(dio, imgUrl, fullPath);
//                   },
//                   icon: const Icon(
//                     Icons.download,
//                     color: Colors.white,
//                   ),
//                 );
//         },
//       ),
//     ]);
//   }
// }

// Future download2(Dio dio, String url, String savePath) async {
//   try {
//     Response response = await dio.get(
//       url,
//       onReceiveProgress: showDownloadProgress,
//       //Received data with List<int>
//       options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           }),
//     );
//     print('hhhhhhhhhhhhhE');
//     print(response.headers);
//     File file = File(savePath);
//     var raf = file.openSync(mode: FileMode.write);
//     // response.data is List<int> type
//     raf.writeFromSync(response.data);
//     await raf.close();
//     //OpenFile.open(file.path);
//   } catch (e) {
//     print(e);
//   }
// }

// // download progress
// void showDownloadProgress(received, total) {
//   if (total != -1) {
//     print((received / total * 100).toStringAsFixed(0) + "%");
//   }
// }


