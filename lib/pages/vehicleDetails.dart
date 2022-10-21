import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/temporaryBackend.dart';
import 'package:wikidados_teste/pages/vehiclePage.dart';

class VehicleDetails extends StatefulWidget {
  VehicleDetails({
    super.key,
    required this.carID,
  });

  final int carID;

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  bool isEditMode = false, isDeleted = false;

  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();

  void handleDelete(String carID) {
    setState(() {
      isDeleted = true;
    });

    Provider.of<TemporaryBackend>(context, listen: false).deleteCar(carID);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (isEditMode
            ? () {
                Provider.of<TemporaryBackend>(context, listen: false).editCar(
                  widget.carID,
                  _brandController.text,
                  _modelController.text,
                  _plateController.text,
                  _yearController.text,
                );

                setState(() {
                  isEditMode = false;
                });
              }
            : () {
                setState(() {
                  isEditMode = true;
                });
              }),
        child: Icon(isEditMode ? Icons.update : Icons.edit),
      ),
      body: isDeleted
          ? Container()
          : Consumer<TemporaryBackend>(builder: (context, backend, child) {
              Map<String, String> car = backend.getCar(widget.carID);

              // I dont know WHY, but where only works if i do this, don't blame me, blame the google
              ImageProvider network = NetworkImage(car["image"]!);
              ImageProvider local = FileImage(File(car["image"]!));
              ImageProvider image =
                  car["imageFromURL"] == "true" ? network : local;

              return Container(
                padding: EdgeInsets.only(bottom: 15),
                child: ListView(
                  children: [
                    Container(
                        height: isEditMode ? 200 : 300,
                        width: double.infinity,
                        child: Image(
                          image: image,
                          fit: BoxFit.cover,
                        )),
                    isEditMode
                        ? Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Editar Veículo",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  controller: _brandController
                                    ..text = car["brand"]!,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Marca",
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _modelController
                                    ..text = car["model"]!,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Modelo",
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _plateController
                                    ..text = car["plate"]!,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Placa",
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _yearController
                                    ..text = car["year"]!,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Ano",
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  child: MaterialButton(
                                    onPressed: () {
                                      handleDelete(car["id"]!);
                                    },
                                    color: Colors.red,
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "Excluir",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          left: 15,
                                          right: 15,
                                          bottom: 5),
                                      child: Text(
                                        car["model"] ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: 15, left: 15, bottom: 15),
                                      child: Text(car["brand"] ?? "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.blue)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Ano: ${car["year"]}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("-",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("Placa: ${car["plate"]}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            }),
    );
  }
}
