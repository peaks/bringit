/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
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
