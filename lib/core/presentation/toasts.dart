import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showNoConnectionToast(
  String message,
  BuildContext context,
) async {
  await showFlash(
    duration: const Duration(seconds: 4),
    context: context,
    builder: (contxt, controller) {
      return Flash.dialog(
        controller: controller,
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.black.withOpacity(0.7),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  );
}
