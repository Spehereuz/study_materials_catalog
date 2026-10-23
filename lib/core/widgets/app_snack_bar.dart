import 'package:flutter/material.dart';

/// Коротке повідомлення внизу вікна, яке замінює попереднє.
void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
