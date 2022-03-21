// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  double imc = 0.0;
  String text = "";
  String infoText = "";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      text = "";
      infoText = "";
    });
  }

  void calculateIMC() {
    double _weight = double.parse(weightController.text);
    double _height = double.parse(heightController.text) / 100;

    setState(() {
      imc = _weight / (_height * _height);
      text = imc.toStringAsFixed(2);

      if (imc >= 40) {
        infoText = "Obesidade III";
      } else if (imc >= 30) {
        infoText = "Obesidade II";
      } else if (imc >= 25) {
        infoText = "Sobrepeso";
      } else if (imc >= 18.5) {
        infoText = "Normal";
      } else {
        infoText = "Magreza";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("IMC Calculator"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  resetFields();
                })
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        size: 200,
                        color: Colors.green,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Weight (Kg)",
                                labelStyle: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                              controller: weightController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field can't be empty";
                                }
                              })),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Height (cm)",
                            labelStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          controller: heightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(120, 20, 120, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                calculateIMC();
                              }
                            },
                            child: const Text(
                              "Calculate",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              fixedSize: const Size(100, 50),
                            ),
                          )),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 35,
                            color: Colors.green,
                            fontWeight: FontWeight.w900),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            infoText,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ))
                    ]))));
  }
}
