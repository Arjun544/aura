String getFileName(String path, {required String folder}) =>
    path.toString().split('$folder/').last;
