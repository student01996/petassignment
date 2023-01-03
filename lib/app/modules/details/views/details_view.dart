import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pets/app/modules/home/controllers/home_controller.dart';
import 'package:pets/app/modules/imageview/controllers/imageview_controller.dart';
import 'package:pets/app/modules/imageview/views/imageview_view.dart';
import 'package:pets/app/modules/secure_storage.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
        // stream: null,
        builder: (controller) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('DetailsView'),
              centerTitle: true,
            ),
            body: Column(children: [
              GestureDetector(
                onTap: () {
                  ImageviewController imageviewController =
                      Get.put(ImageviewController());
                  imageviewController.petUrl = controller.pet!.image;
                  Get.to(() => ImageviewView());
                },
                child: Container(
                  width: Get.width,
                  child: CachedNetworkImage(imageUrl: controller.pet!.image),
                ),
              ),
              SizedBox(height: 10),
              Container(
                // width: 100,
                child: Text(
                    "Name: ${Get.find<HomeController>().list_of_pets[controller.indexOfPet].name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              Container(
                // width: 100,
                child: Text(
                    "Age: ${Get.find<HomeController>().list_of_pets[controller.indexOfPet].age.toString()}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              Container(
                // width: 100,
                child: Text(
                    "Price: Rs.${Get.find<HomeController>().list_of_pets[controller.indexOfPet].price}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              (Get.find<HomeController>()
                          .displayedpets[controller.indexOfPet]
                          .adoptme ==
                      0)
                  ? GestureDetector(
                      onTap: () async {
                        Get.find<HomeController>()
                            .displayedpets[controller.indexOfPet]
                            .adoptme = 1;
                        Get.find<HomeController>().adopted_pets += " " +
                            Get.find<HomeController>()
                                .list_of_pets[controller.indexOfPet]
                                .name;
                        await SecureStorage.save("PetHistory",
                            Get.find<HomeController>().adopted_pets);
                        Get.find<HomeController>().adoptingPet(
                            Get.find<HomeController>()
                                .displayedpets[controller.indexOfPet]
                                .name,
                            Get.find<HomeController>()
                                .displayedpets[controller.indexOfPet]
                                .age,
                            Get.find<HomeController>()
                                .displayedpets[controller.indexOfPet]
                                .price,
                            Get.find<HomeController>()
                                .displayedpets[controller.indexOfPet]
                                .adoptme,
                            Get.find<HomeController>()
                                .displayedpets[controller.indexOfPet]
                                .image);
                        Get.find<HomeController>().getData();
                        // controller.petname = Get.find<HomeController>()
                        //     .list_of_pets[controller.indexOfPet]
                        //     .name;
                        controller.confettiController.play();
                        Get.defaultDialog(
                            title: "Pet Adopted",
                            middleText:
                                "You've now adopted ${Get.find<HomeController>().displayedpets[controller.indexOfPet].name}",
                            barrierDismissible: false,
                            onCancel: () {
                              controller.confettiController.stop();
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "Adopt me",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  : GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text("Already Adopted",
                              style: TextStyle(color: Colors.white))),
                    )
            ]),
          ),
          ConfettiWidget(
            confettiController: controller.confettiController,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 80,
            emissionFrequency: 0.2,
            minBlastForce: 10,
            maxBlastForce: 100,
          ),
        ],
      );
    });
  }
}
