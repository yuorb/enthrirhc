(String, String) parseFilename(String filename) {
  if (!filename.contains('.')) {
    return (filename, '');
  }
  final dotIndex = filename.lastIndexOf('.');
  final name = filename.substring(0, dotIndex);
  final ext = filename.substring(dotIndex + 1);
  return (name, ext);
}
