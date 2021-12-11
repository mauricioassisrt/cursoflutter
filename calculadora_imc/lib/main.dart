import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoInput = TextEditingController();
  TextEditingController alturaInput = TextEditingController();
  String textInfo = "Informe seus dados";

  void _resetFields() {
    pesoInput.text = "";
    alturaInput.text = "";
    textInfo = "Informeadasd seus dados ";
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoInput.text);
      double altura = double.parse(alturaInput.text) / 100;

      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        textInfo = "Abaixo do IMC(${imc})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculador IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person,
              size: 120,
              color: Colors.blue,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso Em KG",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              controller: pesoInput,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura em Centimetros",
                labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 20),
              controller: alturaInput,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20.0),
              child: Container(
                height: 50,
                child: RaisedButton(
                  onPressed: _calculate,
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Text(
              textInfo,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
