import 'package:flutter/material.dart';

class TemporaryBackend extends ChangeNotifier {
  List<Map<String, String>> carList = [
    {
      "name": "Ferrari",
      "image":
          "https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960",
      "imageFromURL": "true"
    },
    {
      "name": "Lamborghini Aventador",
      "image":
          "https://cdn.motor1.com/images/mgl/4JyZA/s1/lamborghini-aventador-lp-780-4-ultimae.webp",
      "imageFromURL": "true"
    },
    {
      "name": "Bugatti Chiron",
      "image":
          "https://quatrorodas.abril.com.br/wp-content/uploads/2021/10/bugatti_chiron_super_sport_5_0ae608cc0d5f0840.jpg?quality=70&strip=info",
      "imageFromURL": "true"
    }
  ];

  void addCar(String name, String image) {
    carList.add({"name": name, "image": image, "imageFromURL": "false"});
    notifyListeners();
  }
}
