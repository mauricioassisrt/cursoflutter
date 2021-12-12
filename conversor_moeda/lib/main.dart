import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.hgbrasil.com/finance?format=json&key=xxxxxxxx";

void main() async {
//  print(await getData());
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return jsonDecode(response.body);
}

class _HomeState extends State<Home> {
  final realControler = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text){
    print(text);
  }

  void _dolarChanged(String text){
    print(text);
  }


  void _euroChanged(String text){
  print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      "Carregando ",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro ao carregar dados ",
                        style: TextStyle(color: Colors.amber, fontSize: 25),
                      ),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            size: 120,
                            color: Colors.amber,
                          ),
                          buildTextField("Reais", "R\$", realControler, _realChanged),
                          Divider(),
                          buildTextField("Dolar", "US\$", dolarController,_dolarChanged),
                          Divider(),
                          buildTextField("Euros", "E\$", euroController, _euroChanged)
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    textAlign: TextAlign.center,
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 20),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
