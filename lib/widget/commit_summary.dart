import 'package:flutter/material.dart';
import 'package:git_ihm/widget/summary_widget.dart';

class CommitSummary extends StatelessWidget {
  const CommitSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCommitSummary(
      hashValue: '454fdf5d',
    );
  }
}
