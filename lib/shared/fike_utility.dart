import 'dart:typed_data';

import 'package:mime/mime.dart';

class FileUtility {
  static String checkFiletype({required Uint8List file}) {
    return ".${lookupMimeType('', headerBytes: file)!.split('/').last}";
  }
}
