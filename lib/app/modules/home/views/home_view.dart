import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: ListView.builder(
        itemCount: controller.product.length,
        itemBuilder:
            (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text('${controller.product[index]['id']}'),
              ),
              title: Text('${controller.product[index]['name']}'),
              subtitle: Text('${controller.product[index]['desc']}'),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getPDF,
        child: Icon(Icons.note),
      ),
    );
  }
}
