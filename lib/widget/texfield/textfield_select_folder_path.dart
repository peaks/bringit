import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../modal/custom_form_field.dart';

class TextfieldSelectFolderPath extends StatefulWidget {
  const TextfieldSelectFolderPath(
      {Key? key,
      required this.isProjectPathValid,
      required this.label,
      required this.pathDirectoryController})
      : super(key: key);
  final bool isProjectPathValid;
  final String label;
  final TextEditingController pathDirectoryController;

  @override
  State<TextfieldSelectFolderPath> createState() =>
      _TextfieldSelectFolderPathState();
}

class _TextfieldSelectFolderPathState extends State<TextfieldSelectFolderPath> {
  String? selectedDirectory;
  TextEditingController pathDirectory = TextEditingController();
  @override
  void initState() {
    super.initState();
    pathDirectory = widget.pathDirectoryController;
  }

  Future<void> selectDirectory() async {
    selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      print('No file selected');
    } else {
      pathDirectory.text = selectedDirectory.toString();
      print(selectedDirectory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 20),
      child: CustomTextFormField(
        readOnly: true,
        labelText: widget.label,
        hintText: '',
        inputIsValid: widget.isProjectPathValid,
        controller: widget.pathDirectoryController,
        suffixIcon: IconButton(
            icon: const Icon(
              Icons.folder,
            ),
            onPressed: selectDirectory),
        onChanged: (String? val) {
          print(val);
        },
      ),
    );
  }
}
