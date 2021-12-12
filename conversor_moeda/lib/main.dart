import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
const request = "http://api.hgbrasil.com/finance?format=json&key=xxxxxxxx";

void main() async {

 // http.Response response = await http.get(Uri.parse(request));
  //jsonDecode(response.body)["results"]["currencies"]["USD"]

  //print( jsonDecode(response.body)["results"]["currencies"]["USD"]);
  runApp(MaterialApp(
      home: Container()
  ));
}

Future<Map> getData() async{

  http.Response response = await http.get(Uri.parse(request));
  return jsonDecode(response.body);
}