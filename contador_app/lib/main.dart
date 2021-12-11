import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  //build é um metodo da classe statelessWidget
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
//widget com tipo stateles nunca muda o estado
//o widget statefull ele pode atualizar os widget na tela
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int variavel = 0;

  void decrement() {
    setState(() {
      if (variavel > 0) {
        variavel--;
      }
    });
  }

  void increment() {
    setState(() {
      if (variavel < 10) {
        variavel++;
      }
      print(variavel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/1.png'), fit: BoxFit.cover),
          ),
          child: Column(
            //alinha os elementos no centro
            mainAxisAlignment: MainAxisAlignment.center,
            //FILHOS [] FILHO ()
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pode entrar",
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    variavel.toString(),
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.red,
                        fontWeight: FontWeight.w900),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //filhos
                children: <Widget>[
                  TextButton(
                    onPressed: increment,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(100, 100),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Entrou',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(100, 100),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: decrement,
                    child: Text(
                      'Saiu',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
