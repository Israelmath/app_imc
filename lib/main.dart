import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _peso_controlador = TextEditingController();
  TextEditingController _altura_controlador = TextEditingController();
  String _infoText = 'Informe seus dados';

  void _resetData() {
    _peso_controlador.text = '';
    _altura_controlador.text = '';
    _infoText = 'Informe seus dados';
  }

  bool _validate(TextEditingController altura_peso, bool altura){

    if (altura_peso == null){
      if (altura == false){
        _infoText = 'Você precisa informar o peso';
        return false;
      }
      else{
        _infoText = 'Você precisa informar a altura';
        return false;
      }
    }else
      return true;
  }

  void _calcula_imc() {
    setState(
      () {
        if (_validate(_peso_controlador, false) && _validate(_altura_controlador, true)){

          debugPrint('_peso_controlador: ${_peso_controlador.text}');
          debugPrint('_altura_controlador: ${_altura_controlador.text}');

          double _peso = double.tryParse(_peso_controlador.text);
          double _altura = double.tryParse(_altura_controlador.text);
          double _imc = _peso / (_altura * _altura);

          if (_imc < 18.6) {
            _infoText = 'Abaixo do peso\nIMC: ${_imc.toStringAsFixed(2)}';
          } else if (_imc >= 18.6 && _imc < 24.9) {
            _infoText = 'Dentro do peso ideal\nIMC: ${_imc.toStringAsFixed(2)}';
          } else if (_imc >= 24.9 && _imc < 34.9) {
            _infoText = 'Obesidade Grau I\nIMC: ${_imc.toStringAsFixed(2)}';
          } else if (_imc >= 34.9 && _imc < 39.9) {
            _infoText = 'Obesidade Grau II\nIMC: ${_imc.toStringAsFixed(2)}';
          } else {
            _infoText = 'Obesidade Grau III\nIMC: ${_imc.toStringAsFixed(2)}';
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[500],
        accentColor: Colors.brown[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[500],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculador de IMC'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetData,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.orange[500],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: TextField(
                  controller: _peso_controlador,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange[500]),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '83.2',
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: TextField(
                  controller: _altura_controlador,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange[500]),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '170',
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: _calcula_imc,
                    child: Text('Calcular'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: Text(
                  _infoText,
                  style: TextStyle(
                    color: Colors.orange[500],
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
