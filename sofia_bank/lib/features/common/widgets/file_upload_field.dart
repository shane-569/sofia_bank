import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadField extends StatelessWidget {
  final String label;
  final String? fileName;
  final String? errorText;
  final ValueChanged<XFile?> onFilePicked;

  const FileUploadField({
    super.key,
    required this.label,
    this.fileName,
    this.errorText,
    required this.onFilePicked,
  });

  Future<void> _pickFile(BuildContext context) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    onFilePicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: Text(fileName == null ? 'Upload $label' : 'Change $label'),
          onPressed: () => _pickFile(context),
        ),
        if (fileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              fileName!,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }
}
