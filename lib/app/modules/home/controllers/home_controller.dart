import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets/app/modules/details/controllers/details_controller.dart';
import 'package:pets/app/modules/home/singlePet.dart';
import 'package:pets/app/modules/secure_storage.dart';

import '../../../sqflitehelper.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  List<singlePet> list_of_pets = [];
  List<singlePet> displayedpets = [];
  List<singlePet> history_of_pets = [];
  bool fromDetails = false;
  String adopted_pets = "";
  final count = 0.obs;
  String name = "";
  String price = "";
  int age = 0;
  String image = "";
  TextEditingController textEditingController = new TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();

    // initializinglist();
    // putDatainDatabase();
    await readingData();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  readingData() async {
    String? firstCheck = await SecureStorage.read('RanTheApp');
    if (firstCheck == null) {
      SecureStorage.save('RanTheApp', 'Yes');
      print('First Run  is this');
      initializinglist();
      putDatainDatabase();
      adopted_pets = "";
    } else if (firstCheck == 'Yes') {
      print('Not First Run');
      String? readPets = await SecureStorage.read("PetHistory");
      if (readPets != null) adopted_pets = readPets;
    }
    print(adopted_pets);
  }

  initializinglist() {
    list_of_pets = [
      singlePet(
          "Dog",
          5,
          "10K",
          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=640:*",
          0),
      singlePet(
          "Cat",
          4,
          "2K",
          "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=600",
          0),
      singlePet(
          "Horse",
          10,
          "4L",
          "https://images.pexels.com/photos/1996333/pexels-photo-1996333.jpeg?auto=compress&cs=tinysrgb&w=600",
          0),
      singlePet(
          "Parrot",
          2,
          "1K",
          "https://images.pexels.com/photos/1478419/pexels-photo-1478419.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0),
      singlePet(
          "Rat",
          3,
          "3K",
          "https://images.pexels.com/photos/51340/rat-pets-eat-51340.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0),
      singlePet(
          "Rabbit",
          2,
          "6K",
          "https://images.pexels.com/photos/4001296/pexels-photo-4001296.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0),
      singlePet(
          "Hamster",
          4,
          "10K",
          "https://images.pexels.com/photos/4520481/pexels-photo-4520481.jpeg?auto=compress&cs=tinysrgb&w=600",
          0),
      singlePet(
          "Pigeon",
          2,
          "3K",
          "https://images.pexels.com/photos/75973/pexels-photo-75973.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0),
      singlePet(
          "Turtle",
          10,
          "20K",
          "https://images.pexels.com/photos/2613148/pexels-photo-2613148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0),
      singlePet(
          "Pig",
          10,
          "15K",
          "https://images.pexels.com/photos/110820/pexels-photo-110820.jpeg?auto=compress&cs=tinysrgb&w=600",
          0)
    ];
  }

  putDatainDatabase() {
    list_of_pets.forEach((element) {
      _addItem(element.name, element.age, element.price, element.adoptme,
          element.image);
    });
  }

  void increment() => count.value++;
  getData() async {
    final data = await SQLHelper.getItems();
    list_of_pets.clear();
    data.forEach((element) {
      list_of_pets.add(singlePet(element["name"], element["age"],
          element["price"], element["image"], element["adoptme"]));
    });
    displayedpets = list_of_pets;
    print('Data From The Database is:');
    print(data);
    if (fromDetails) Get.find<DetailsController>().update();
    update();
  }

  adoptingPet(String name, int age, String price, int adoptme, String image) {
    _updateItem(name, age, price, adoptme, image);
  }

  Future<void> _addItem(
      var name, int age, var price, int adoptme, var image) async {
    await SQLHelper.createItem(name, age, price, adoptme, image);
  }

// Update an existing journal
  Future<void> _updateItem(
      var name, int age, var price, int adoptme, var image) async {
    await SQLHelper.updateItem(name, age, price, adoptme, image);
  }

// Delete an item
  void _deleteItem(var name) async {
    await SQLHelper.deleteItem(name);
  }

  Future<void> _deleteAll() async {
    await SQLHelper.deleteAll();
  }
}
