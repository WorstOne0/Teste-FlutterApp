import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/temporaryBackend.dart';

class VehicleRegister extends StatefulWidget {
  VehicleRegister({super.key});

  @override
  State<VehicleRegister> createState() => _VehicleRegisterState();
}

class _VehicleRegisterState extends State<VehicleRegister> {
  final ImagePicker _picker = ImagePicker();

  XFile? _pickedFile;

  String urlImage = "";
  final _modelController = TextEditingController();
  final _brandController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();

  void handleSubmit() {
    if (_brandController.text == "") return;

    print(_pickedFile!.path);
    Provider.of<TemporaryBackend>(context, listen: false)
        .addCar(_brandController.text, _pickedFile!.path);

    Navigator.of(context).pop();
  }

  void takeImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedFile = image;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 120,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              "Escolha o metodo",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(children: [
                        Icon(Icons.language),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "URL",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        takeImage();
                      },
                      child: Row(children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Galeria")
                      ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registar um Veículo"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            GestureDetector(
              onTap: (() {
                showModalBottomSheet(
                    context: context, builder: (builder) => bottomSheet());
              }),
              child: Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: _pickedFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 120),
                          Text("Carregar Imagem")
                        ],
                      )
                    : Image(
                        image: FileImage(File(_pickedFile!.path)),
                      ),
              ),
            ),

            //
            TextField(
              controller: _brandController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Marca",
              ),
            ),

            // Padding
            SizedBox(
              height: 15,
            ),

            //
            TextField(
              controller: _modelController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Modelo",
              ),
            ),

            // Padding
            SizedBox(
              height: 15,
            ),

            //
            TextField(
              controller: _plateController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Placa",
              ),
            ),

            // Padding
            SizedBox(
              height: 15,
            ),

            //
            TextField(
              controller: _yearController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ano",
              ),
            ),

            // Padding
            SizedBox(
              height: 15,
            ),

            // Submit Button
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: handleSubmit,
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Adicionar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
