import 'package:flutter/material.dart';
import 'package:git_ihm/widget/modal/custom_form_field.dart';

class TextfieldProjectName extends StatefulWidget {
  const TextfieldProjectName(
      {Key? key,
      required this.isProjectNameValid,
      required this.pathDirectoryController,
      required this.isProjectNameNotYetModified,
      required this.onProjectNameChanged,
      required this.projectNameMessageError})
      : super(key: key);
  final bool isProjectNameValid;
  final TextEditingController pathDirectoryController;
  final bool isProjectNameNotYetModified;
  final Future<void> Function(String val) onProjectNameChanged;
  final String projectNameMessageError;

  @override
  State<TextfieldProjectName> createState() => _TextfieldProjectNameState();
}

class _TextfieldProjectNameState extends State<TextfieldProjectName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextFormField(
          readOnly: false,
          labelText: 'Name',
          hintText: 'project name',
          errorText: widget.projectNameMessageError,
          inputIsValid: widget.isProjectNameValid,
          onChanged: (String? val) => widget.onProjectNameChanged(val ?? ''),
          suffixIcon: !widget.isProjectNameNotYetModified
              ? IconButton(
                  icon: widget.isProjectNameValid
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(Icons.warning_amber,
                          color: Theme.of(context).colorScheme.onError),
                  onPressed: () {},
                )
              : null),
    );
  }
}
