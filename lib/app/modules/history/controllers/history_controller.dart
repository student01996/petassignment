import 'package:get/get.dart';
import 'package:pets/app/modules/secure_storage.dart';
import 'package:pets/app/sqflitehelper.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController
  List<String>? pets;
  List<String>? petUrl;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    get_history();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  get_history() async {
    String? petHistory = await SecureStorage.read("PetHistory");
    print(petHistory);
    if (petHistory != null) {
      pets = petHistory.split(" ");
      if (pets != null) {
        pets!.removeAt(0);
        pets!.forEach((element) async {
          print("element=");
          print(element);
          if (element != "") {
            var pet = await SQLHelper.getItem(element);
            print("pet=");
            print(pet);
            if (petUrl == null) {
              petUrl = [pet[0]["image"]];
            } else {
              print(pet[0]["image"]);
              petUrl!.add(pet[0]["image"]);
            }
            print("peturl is");
            print(petUrl![0]);
          }
        });
      }
    }
    update();
  }

  void increment() => count.value++;
}
