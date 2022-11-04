import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({Key? key}) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Payload navigation',
        style: context.titleLarge,
      ),
    );
  }
}
