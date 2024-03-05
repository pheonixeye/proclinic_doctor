import 'package:flutter/material.dart';

void handleIfMounted(BuildContext context, {dynamic function}) {
  if (context.mounted) {
    function();
  }
}
