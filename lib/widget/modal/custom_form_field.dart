import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.onFieldSubmitted,
    required this.inputIsValid,
    this.controller,
    required this.labelText,
    this.readOnly = false,
  }) : super(key: key);
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final IconButton? suffixIcon;
  final String? errorText;
  final String labelText;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final bool inputIsValid;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        errorText: errorText,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.onError,
        ),
        errorBorder: inputIsValid
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onError, width: 1)),
        filled: true,
        fillColor: readOnly
            ? Theme.of(context).primaryColorDark
            : Theme.of(context).colorScheme.secondaryContainer,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
