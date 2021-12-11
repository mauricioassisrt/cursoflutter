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
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  String textInfo = "Informe seus dados";

  void _resetFields() {
    pesoInput.text = "";
    alturaInput.text = "";
    setState(() {
      textInfo = "Informe seu peso ";
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoInput.text);
      double altura = double.parse(alturaInput.text) / 100;

      double imc = peso / (altura * altura);
      print(imc);
      if (imc <= 18.5) {
        textInfo = "Abaixo do Peso(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        textInfo = "Peso ideal(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc <= 29.9) {
        textInfo = "Levemente acima do  Peso(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc <= 39.9) {
        textInfo = "Acima do Peso(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        textInfo = "Além  do Peso(${imc.toStringAsPrecision(4)})";
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 120,
                color: Colors.blue,
              ),
              TextFormField(
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
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira o seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura em Centimetros",
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 20),
                controller: alturaInput,
                validator: (value){
                  if(value!.isEmpty ){
                  return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
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
      ),
    );
  }
}
