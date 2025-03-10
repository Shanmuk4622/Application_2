import 'dart:io';
import 'dart:convert';  // For decoding data
import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static Future<String?> pickFile() async {
    print('Starting file picker...');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      print('File selected: ${result.files.single.name}');
      File file = File(result.files.single.path!);

      try {
        // Read as binary data first
        List<int> bytes = await file.readAsBytes();

        // Attempt UTF-8 decoding first
        String fileContent = utf8.decode(bytes, allowMalformed: true);

        print('File content loaded successfully.');
        return fileContent.length > 300
            ? fileContent.substring(0, 300) + '...\n\n[Content Trimmed]'
            : fileContent;

      } catch (e) {
        print('Error reading file: $e');
        return 'Error: Unable to read file content.';
      }
    } else {
      print('File selection cancelled.');
      return null;
    }
  }
}
