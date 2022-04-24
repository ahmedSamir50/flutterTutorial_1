import 'package:flutter/foundation.dart';

void printOnyOnDebugMode(List<dynamic> params) {
  if (kDebugMode) {
    print([...params]);
  }
}
