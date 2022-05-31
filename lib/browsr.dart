import 'package:browsr/urls.dart';
import 'package:flutter/services.dart';

class Browsr {
  static const MethodChannel _channel = MethodChannel('browsr');

  static Future<Map?> get getOrgList async {
    Map data = {"url": Urls.orgListingUrl};

    return await _channel.invokeMethod('getCall', data).then((value) {
      return value ?? {};
    }).catchError((onError) => throw (onError));
  }
}
