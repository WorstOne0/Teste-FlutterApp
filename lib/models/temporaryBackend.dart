import 'package:flutter/material.dart';

class TemporaryBackend extends ChangeNotifier {
  List<Map<String, String>> _carList = [
    {
      "id": "0",
      "brand": "Ferrari",
      "model": "SF90 Stradale",
      "plate": "ABC-0123",
      "year": "2021",
      "image":
          "https://di-uploads-pod16.dealerinspire.com/continentalferrari/uploads/2021/01/SF90-Large.jpg",
      "imageFromURL": "true"
    },
    {
      "id": "1",
      "brand": "Ferrari",
      "model": "Roma",
      "plate": "ABC-0123",
      "year": "2021",
      "image":
          "https://di-uploads-pod16.dealerinspire.com/continentalferrari/uploads/2021/01/Roma-Large.jpg",
      "imageFromURL": "true"
    },
    {
      "id": "2",
      "brand": "Ferrari",
      "model": "296 GTB",
      "plate": "ABC-0123",
      "year": "2021",
      "image":
          "https://di-uploads-pod16.dealerinspire.com/continentalferrari/uploads/2021/07/296GTB-Large.jpg",
      "imageFromURL": "true"
    },
    {
      "id": "3",
      "brand": "Lamborghini",
      "model": "Aventador",
      "plate": "ABC-0123",
      "year": "2022",
      "image":
          "https://cdn.motor1.com/images/mgl/4JyZA/s1/lamborghini-aventador-lp-780-4-ultimae.webp",
      "imageFromURL": "true"
    },
    {
      "id": "4",
      "brand": "MacLaren",
      "model": "720S SPIDER",
      "plate": "ABC-0123",
      "year": "2022",
      "image":
          "https://cars.mclaren.com/content/dam/mclaren-automotive/models/720s/720s-spider/720s-spider-extra-assets/car_shadow_03_transparent%20(1).png",
      "imageFromURL": "true"
    },
    {
      "id": "5",
      "brand": "MacLaren",
      "model": "P1",
      "plate": "ABC-0123",
      "year": "2022",
      "image":
          "https://quatrorodas.abril.com.br/wp-content/uploads/2020/07/mclaren_p1_663.jpeg?quality=70&strip=info",
      "imageFromURL": "true"
    },
    {
      "id": "6",
      "brand": "Bugatti",
      "model": "Chiron",
      "plate": "ABC-0123",
      "year": "2021",
      "image":
          "https://quatrorodas.abril.com.br/wp-content/uploads/2021/10/bugatti_chiron_super_sport_5_0ae608cc0d5f0840.jpg?quality=70&strip=info",
      "imageFromURL": "true"
    },
  ];

  // Return the car List with filter logic, [String? brand] means that the field isn't required and can be null
  List<Map<String, String>> getCarList(
      [String? model, String? brand, String? plate, String? year]) {
    // .where() returns the element if the function returns true, .toList() transforms into a list
    return _carList.where((element) {
      // If all fields are null, return all the list
      if (model == null && brand == null && plate == null && year == null) {
        return true;
      }

      bool modelShouldReturn = false,
          brandShouldReturn = false,
          plateShouldReturn = false,
          yearShouldReturn = false;

      // If there is something in brand, check in the database if the element starts with the field search
      if (model != null &&
          element["model"]?.toLowerCase().startsWith(model.toLowerCase()) ==
              true) {
        modelShouldReturn = true;
      }

      if (brand != null &&
          element["brand"]?.toLowerCase().startsWith(brand.toLowerCase()) ==
              true) {
        brandShouldReturn = true;
      }

      if (plate != null &&
          element["plate"]?.toLowerCase().startsWith(plate.toLowerCase()) ==
              true) {
        plateShouldReturn = true;
      }

      if (year != null &&
          element["year"]?.toLowerCase().startsWith(year.toLowerCase()) ==
              true) {
        yearShouldReturn = true;
      }

      // Only if the field isn't null check if the word was found before
      return (model != null ? modelShouldReturn : true) &&
          (brand != null ? brandShouldReturn : true) &&
          (plate != null ? plateShouldReturn : true) &&
          (year != null ? yearShouldReturn : true);
    }).toList();
  }

  Map<String, String> getCar(int carID) {
    return _carList.firstWhere(
      (element) => element["id"] == carID.toString(),
      orElse: () {
        return {"": ""};
      },
    );
  }

  void addCar(
      String brand, String model, String plate, String year, String image) {
    int id = int.parse(_carList.last["id"]!);

    _carList.add({
      "id": (id + 1).toString(),
      "brand": brand,
      "model": model,
      "plate": plate,
      "year": year,
      "image": image,
      "imageFromURL": "false"
    });

    notifyListeners();
  }

  void editCar(
      int carID, String brand, String model, String plate, String year) {
    Map<String, String> car = _carList
        .firstWhere((element) => element["id"] == carID.toString(), orElse: () {
      return {"": ""};
    });

    car.update("brand", (value) => brand);
    car.update("model", (value) => model);
    car.update("plate", (value) => plate);
    car.update("year", (value) => year);

    notifyListeners();
  }

  void deleteCar(String carID) {
    int intCarID = int.parse(carID);

    _carList.removeWhere((item) => item["id"] == carID);

    notifyListeners();
  }
}
