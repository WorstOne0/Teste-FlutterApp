import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/temporaryBackend.dart';
import 'package:wikidados_teste/pages/vehicleRegister.dart';

class VehiclePage extends StatelessWidget {
  VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Veículos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => VehicleRegister()));
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<TemporaryBackend>(
        builder: (context, backend, child) => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: backend.carList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 32,
                        child: CircleAvatar(
                            radius: 30,
                            // ignore: unrelated_type_equality_checks
                            // backgroundImage: NetworkImage(
                            //     backend.carList[index]["image"]!))

                            backgroundImage: backend.carList[index]
                                        ["imageFromURL"] ==
                                    "true"
                                ? NetworkImage(backend.carList[index]["image"]!)
                                : Image(
                                    image: FileImage(
                                        File(backend.carList[index]["image"]!)),
                                  ).image),
                      ),

                      // Padding
                      SizedBox(
                        width: 15,
                      ),

                      Expanded(
                        child: Text(
                          backend.carList[index]["name"]!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
