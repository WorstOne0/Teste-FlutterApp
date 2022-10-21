import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/temporaryBackend.dart';
import 'package:wikidados_teste/pages/vehicleDetails.dart';
import 'package:wikidados_teste/pages/vehicleRegister.dart';

class VehiclePage extends StatefulWidget {
  VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final _searchController = TextEditingController();

  String? search;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(searchOnChange);
  }

  void searchOnChange() {
    setState(() {
      search = _searchController.text == "" ? null : _searchController.text;
    });
  }

  void handleClick(int carID) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VehicleDetails(
              carID: carID,
            )));
  }

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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: // Email Text Field
                TextField(
              controller: _searchController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Busca",
                  labelStyle: TextStyle(fontSize: 18),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Consumer<TemporaryBackend>(
                  builder: (context, backend, child) {
                List<Map<String, String>> carList = backend.getCarList(search);

                return carList.length == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Icon(Icons.youtube_searched_for, size: 80),
                            ),
                            Text(
                              "Desculpe, nenhum item encontado.",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Tente pesquisar novamente.",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: carList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              handleClick(int.parse(carList[index]["id"]!));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 32,
                                    child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: carList[index]
                                                    ["imageFromURL"] ==
                                                "true"
                                            ? NetworkImage(
                                                carList[index]["image"]!)
                                            : Image(
                                                image: FileImage(File(
                                                    carList[index]["image"]!)),
                                              ).image),
                                  ),

                                  // Padding
                                  SizedBox(
                                    width: 15,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                carList[index]["model"]!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),

                                            // Padding
                                            SizedBox(
                                              width: 15,
                                            ),

                                            Text(
                                              carList[index]["plate"]!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  backgroundColor: Colors.grey),
                                            ),
                                          ],
                                        ),

                                        // Padding
                                        SizedBox(
                                          height: 5,
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                carList[index]["brand"]!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),

                                            // Padding
                                            SizedBox(
                                              width: 15,
                                            ),

                                            Text(
                                              carList[index]["year"]!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(Icons.arrow_forward_ios),
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
              }),
            ),
          ),
        ],
      ),
    );
  }
}
