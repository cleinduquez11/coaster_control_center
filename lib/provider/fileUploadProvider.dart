
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fileuploadprovider with ChangeNotifier {
List<String>? files;
  String folderName = '';
  String responseText = "";
  int code = 0;


  Future<void> uploadFiles(name,configPath, rawFiles) async {
    if (rawFiles == null || name == null) return;

    var uri = Uri.parse('http://10.10.56.5:5000/upload');
    var request = http.MultipartRequest('POST', uri);

    request.fields['folder_name'] = name;
    //  files!.add(configPath);
    // request.files.add(await http.MultipartFile.fromPath('files', configPath));
    for (var file in rawFiles!) {
      print(file);
      request.files.add(await http.MultipartFile.fromPath('files', file));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();

      // responseText = responseData;
      code = response.statusCode;
      notifyListeners();

      
      print(responseData);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload successful: $responseData')));
    } else {
      print("Upload failed");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
    }
  }
}
