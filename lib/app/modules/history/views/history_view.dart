import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({Key? key}) : super(key: key);
  HistoryController historyController = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('History View'),
            // actions: [
            //   GestureDetector(
            //     child: Container(child: Icon(Icons.history)),
            //     onTap: (() => Get.to(() => HistoryView())),
            //   )
            // ],
            centerTitle: true,
          ),
          body: (controller.pets == null) || (controller.petUrl == null)
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.green,
                  child: Center(child: Text("No Pet Adopted")),
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  child: ListView.builder(
                      itemCount: controller.pets!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 150,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.petUrl![index],
                                  )),
                              Container(child: Text(controller.pets![index], style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
                            ],
                          ),
                        );
                      }),
                ));
    });
  }
}
