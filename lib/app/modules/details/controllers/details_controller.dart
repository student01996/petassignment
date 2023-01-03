import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:pets/app/modules/home/controllers/home_controller.dart';
import 'package:pets/app/modules/home/singlePet.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController
  singlePet? pet;
  int indexOfPet = 0;
  String petname = "";
  final count = 0.obs;
  bool isPlaying = false;
  ConfettiController confettiController = ConfettiController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Get.find<HomeController>().fromDetails = true;
  }

  @override
  void onClose() {
    Get.find<HomeController>().fromDetails = false;
    super.onClose();
  }

  updateUI() {
    Get.find<HomeController>().update();
    update();
  }

  void increment() => count.value++;
}
