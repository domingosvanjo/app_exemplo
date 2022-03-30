// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final nome = TextEditingController();
  final telefone = TextEditingController();
  final cep = TextEditingController();
  final rua = TextEditingController();
  final bairro = TextEditingController();
  final cidade = TextEditingController();
  final estado = TextEditingController();
  final complemento = TextEditingController();
  final email = TextEditingController();

  @override
  void dispose() {
    nome.dispose();
    telefone.dispose();
    cep.dispose();
    rua.dispose();
    bairro.dispose();
    cidade.dispose();
    estado.dispose();
    complemento.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cep.addListener(busca);
  }

  void busca() {
    rua.text = "";
    bairro.text = "";
    cidade.text = "";
    estado.text = "";
    complemento.text = "";
    if (cep.text.length < 8) {
      AlertDialog(
        content: Text('CEP inválido'),
      );
    } else {
      buscarPorCep();
    }
  }

  void buscarPorCep() async {
    String textCep = cep.text;
    var url = Uri.parse('https://viacep.com.br/ws/$textCep/json/');
    //http.Response response;
    var response = await http.get(url);
    Map<String, dynamic> dados = json.decode(response.body);

    setState(() {
      //cep.text = dados["cep"];
      rua.text = dados["logradouro"];
      complemento.text = dados["complemento"];
      bairro.text = dados["bairro"];
      cidade.text = dados["localidade"];
      estado.text = dados["uf"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de clientes'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                controller: nome,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: 'Nome completo'), 
              ),
              // ignore: prefer_const_literals_to_create_immutables
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: TextField(
                  controller: telefone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: 'Telefone'),
                ),
              ),
              TextField(
                controller: cep,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'CEP'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: TextField(
                  controller: rua,
                  decoration: InputDecoration(
                      labelText: 'Rua'),
                ),
              ),
              TextField(
                controller: complemento,
                decoration: InputDecoration(
                    labelText: 'Complemento'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: TextField(
                  controller: bairro,
                  decoration: InputDecoration(
                      labelText: 'Bairro'),
                ),
              ),
              TextField(
                controller: cidade,
                decoration: InputDecoration(
                    labelText: 'Cidade'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: TextField(
                  controller: estado,
                  decoration: InputDecoration(
                      labelText: 'Estado'),
                ),
              ),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'E-mail'),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 4),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Salvar'),
                  onPressed: () {
                    print('Salvar pressionado');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
