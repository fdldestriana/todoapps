import 'package:flutter/material.dart';
import 'package:todoapps/ui/widgets/custom_alertdialog.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: const Color(0xFFB39DDB),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const CustomAlertDialog();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ));
  }
}
