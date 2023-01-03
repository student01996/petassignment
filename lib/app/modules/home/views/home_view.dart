import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pets/app/modules/details/controllers/details_controller.dart';
import 'package:pets/app/modules/details/views/details_view.dart';
import 'package:pets/app/modules/history/views/history_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
            actions: [
              GestureDetector(
                child: Container(child: Icon(Icons.history)),
                onTap: (() => Get.to(() => HistoryView())),
              )
            ],
            centerTitle: true,
          ),
          body: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      controller: controller.textEditingController,
                      decoration: InputDecoration(
                          prefix: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.blue))),
                      onChanged: (query) {
                        final suggestions =
                            controller.list_of_pets.where((pet) {
                          final petname = pet.name.toLowerCase();
                          final input = query.toLowerCase();
                          return petname.contains(input);
                        }).toList();
                        controller.displayedpets = suggestions;
                        controller.displayedpets.forEach((element) {
                          print(element.name);
                        });
                        controller.update();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.displayedpets.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: Get.width,
                                  color: Colors.blue.shade100,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Text(controller
                                              .displayedpets[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)),
                                      (controller.displayedpets[index]
                                                  .adoptme ==
                                              1)
                                          ? Container(
                                              child: Text("Already Adopted", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.red)))
                                          : Container()
                                    ],
                                  )),
                              onTap:
                                  (controller.displayedpets[index].adoptme == 0)
                                      ? () {
                                          DetailsController detailsController =
                                              Get.put(DetailsController());
                                          detailsController.indexOfPet = index;
                                          detailsController.pet =
                                              controller.displayedpets[index];

                                          Get.to(() => DetailsView());
                                        }
                                      : () {},
                            ),
                            Container(
                              height: 10,
                              width: Get.width,
                            )
                          ],
                        );
                        // title: ,
                        // trailing: ,
                        // onTap:
                        // );
                      },
                    ),
                  ),
                ],
              )));
    });
  }
}
