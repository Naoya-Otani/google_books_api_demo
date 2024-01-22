import 'package:flutter/material.dart';

class WarningModalWidget extends StatelessWidget {
  const WarningModalWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("文字を入力してください！"),
      content: Text("アラート"),
    );
  }
}
