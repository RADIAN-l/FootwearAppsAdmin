import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/home_controller.dart';
import 'add_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: Text("Admin"),),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(icon: Icon(Icons.delete),
                  onPressed: () {
                  ctrl.deleteProduct(ctrl.products[index].id ?? '');
                  },
                ),
              );
            }
        ),
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddProductPage());
          },
        ),
      );
    });
  }
}
