import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista na qual armazena os itens e exibe no front do app
  List _toDoList = [];

  //elemento destinado a armazenar os dados vindos do input
  final getTarefa = TextEditingController();

  //Armazena o objeto que foi excluido o ultimo objeto
  late Map<String, dynamic> _lastRemoved;

  //armazena a posição que foi apagada a ultima
  late int _lastRemovedPos;

//recebe o retorno do json que foi armazenado em um directorio
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  //salva os dados que foram preenchidos no input no json
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  //carrega o retorno dos dados que estão no json
  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

//ao iniciar o app faz a leitura do metodo readData e armazena no toDoList
  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data!);
      });
    });
  }

//Adiciona um novo item
  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = getTarefa.text;
      getTarefa.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

// Ordena os item
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"]) {
          return 1;
        } else if (!a["ok"] && b["ok"]) {
          return 0;
        } else {
          return 0;
        }
        _saveData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //String e = "asdas";
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: getTarefa,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                  ),
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.add),
                  color: Colors.lightBlue,
                  label: Text("Add"),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                ),

              ],

            ),
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: _toDoList.length,
                    itemBuilder: (context, index) {
                      //CHAMAMOS A LISTA NA FUNCAO DO RETURN
                      return buildItem(context, index);
                    })),
          )
        ],
      ),
    );
  }

  //UTILIZADO PARA GERAR A LISTA DE ITENS
  Widget buildItem(context, index) {
    return Dismissible(
      //KEY utilizada para armazenar e criar um código aleatorio para o item ao ser removido
      //isso serve para caso seja necessário reativar o item
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          //caso o index retorne OK ele exibe o icone check caso contrario exibe o error
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          //ao clicar no checkbox ele pega o elemento da lista pelo index e set um true para marcar o checkbox
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          //pega o item da posição ao clicar
          _lastRemoved = Map.from(_toDoList[index]);
          // pega a posição
          _lastRemovedPos = index;
          //remove a posição da lista
          _toDoList.removeAt(index);
          //salva os dados
          _saveData();
          //exibe o desfazer
          final snack = SnackBar(
            content: Text("Tarefa ${_lastRemoved["title"]} Removida !"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  //caso seja o desfazer clicado pega o ultimo elemento removido e insere novamente
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

/**/

}
