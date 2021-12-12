import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';

const request = "http://api.hgbrasil.com/finance?format=json&key=xxxxxxxx";

void main() async {

  http.Response response = await http.get(Uri.parse(request));
  print(response.body);

  runApp(MaterialApp(
      home: Container()
  ));
}