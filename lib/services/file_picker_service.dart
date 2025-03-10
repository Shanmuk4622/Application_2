import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      return 'Selected File: ${file.path.split('/').last}';
    } else {
      return null;
    }
  }
}
