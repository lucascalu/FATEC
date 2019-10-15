import 'package:calc_imc2/models/person.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  var _pessoa1 = Person(peso: 0, altura: 0, genero: "mulher");
  var _pessoa2 = Person(peso: 0, altura: 0, genero: "homem");
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infotext = "Preencha os Campos";
  String _infotext2 = "";
  String selectedRadio = "";
  String _imc2 = "";
  Color cor = Colors.blueAccent[400];

  void _calcMulher() {
    if (selectedRadio == _pessoa1.genero) {
      _calculate();
    } else if (selectedRadio == _pessoa2.genero) {
      _calculate2();
    } else if (selectedRadio == selectedRadio) {
      _showDialogGenero(
        title: "Erro",
        message: "Selecione o Genero!",
      );
    }
  }

  void _mulherForma(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void _resetfields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      cor = Colors.purple[600];
      _infotext = "Preencha os Campos";
      _infotext2 = "";
      _imc2 = "";
      selectedRadio = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      _pessoa1.peso = double.parse(pesoController.text);
      _pessoa1.altura = double.parse(alturaController.text) / 100;
      double imc = _pessoa1.peso / (_pessoa1.altura * _pessoa1.altura);

      _imc2 = "IMC: ";
      _infotext2 = "${imc.toStringAsPrecision(3)}";
      _infotext = "";
      if (imc < 19.0) {
        _infotext += "Abaixo :(";
        cor = Colors.red[600];
      } else if (imc >= 19.0 && imc <= 23.9) {
        _infotext += "Peso Ideal :)";
        cor = Colors.blue[900];
      } else if (imc >= 24.0 && imc <= 28.9) {
        _infotext += "Obesidade Grau 1 :| ";
        cor = Colors.green[900];
      } else if (imc >= 29.0 && imc <= 38.9) {
        _infotext += "Obesidade Grau 2 :[";
        cor = Colors.pink[900];
      } else if (imc >= 39.0) {
        _infotext += "Obesidade Grau 3 :(";
        cor = Colors.black;
      }
    });
  }

  void _calculate2() {
    setState(() {
      _pessoa2.peso = double.parse(pesoController.text);
      _pessoa2.altura = double.parse(alturaController.text) / 100;
      double imc = _pessoa2.peso / (_pessoa2.altura * _pessoa2.altura);

      _imc2 = "IMC: ";
      _infotext2 = "${imc.toStringAsPrecision(3)}";
      _infotext = "";
      if (imc < 20.0) {
        _infotext += "Abaixo :(";
        cor = Colors.red[600];
      } else if (imc >= 20.0 && imc <= 24.9) {
        _infotext += "Peso Ideal :)";
        cor = Colors.blue[900];
      } else if (imc > 24.9 && imc <= 29.9) {
        _infotext += "Obesidade Grau 1 :|";
        cor = Colors.green[900];
      } else if (imc >= 30.0 && imc <= 39.9) {
        _infotext += "Obesidade Grau 2 :[ ";
        cor = Colors.pink[900];
      } else if (imc >= 40.0) {
        _infotext += "Obesidade Grau 3 :(";
        cor = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: buildForm(),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline,
              size: 110.0, color: Colors.deepOrange[700]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                  value: _pessoa1.genero,
                  activeColor: Colors.pink[400],
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    _mulherForma(val);
                  }),
              Text("Mulher",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              Radio(
                  value: _pessoa2.genero,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    _mulherForma(val);
                  }),
              Text(
                "Homem",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso (kg)",
              labelStyle: TextStyle(color: Colors.deepOrange[700]),
            ),
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black87, fontSize: 25.0),
            controller: pesoController,
            validator: (String arg) {
              if (arg.length <= 0) {
                return "Digite seu Peso";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura (cm)",
              labelStyle: TextStyle(color: Colors.deepOrange[700]),
            ),
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black87, fontSize: 25.0),
            controller: alturaController,
            validator: (String arg) {
              if (arg.length <= 0) {
                return "Digite sua Altura";
              } else {
                return null;
              }
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _imc2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                  ),
                ),
                Text(
                  _infotext2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Container(
              height: 50.0,
              child: Text(
                _infotext,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cor,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
            child: Container(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "CALCULAR",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.deepOrange[200],
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _calcMulher();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Calculadora IMC",
        style: TextStyle(fontSize: 30.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepOrange[200],
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetfields,
        ),
      ],
    );
  }

  void _showDialogGenero({String title, String message, Function confirm}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (confirm != null) confirm();
              },
            ),
          ],
        );
      },
    );
  }
}
