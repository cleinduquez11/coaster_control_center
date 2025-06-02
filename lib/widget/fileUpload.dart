import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;



class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  List<PlatformFile>? _files;
  String _folderName = '';

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _files = result.files;
      });
    }
  }

  Future<void> _uploadFiles() async {
    if (_files == null || _folderName.isEmpty) return;

    var uri = Uri.parse('http://127.0.0.1:5000/upload');
    var request = http.MultipartRequest('POST', uri);

    request.fields['folder_name'] = _folderName;
    for (var file in _files!) {
      request.files.add(await http.MultipartFile.fromPath('files', file.path!));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload successful: $responseData')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _folderName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Folder Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFiles,
              child: Text('Pick Files'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _files?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_files![index].name),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _uploadFiles,
              child: Text('Upload Files'),
            ),
          ],
        ),
      ),
    );
  }
}