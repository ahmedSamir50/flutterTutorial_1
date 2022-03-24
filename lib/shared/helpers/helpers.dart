import 'package:flutter/foundation.dart';

void printOnyOnDebugMode(List<dynamic>params){
      if (kDebugMode) {
        for (var element in params) {
          print(element);
        }

      }
}