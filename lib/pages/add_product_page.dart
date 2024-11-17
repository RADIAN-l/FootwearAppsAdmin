import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


import '../controller/home_controller.dart';
import '../widgets/drop_down_bttn.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: Text('Add Product'),),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Add New Product',
                  style: TextStyle(fontSize: 30,
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold),),
                TextField(
                  controller: ctrl.productName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: Text('Product Name'),
                    hintText: 'Enter Your Product Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productDescription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: Text("Product Description"),
                    hintText: "Enter Your Product Description",
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productImgUrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: Text('Image Url'),
                    hintText: 'Enter Your Image Url',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productPrice,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: Text('Product Price'),
                    hintText: 'Enter Your Product Price',
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBttn(items: ['Boots', 'Shoes', 'Sandal','Snicker','Loafer'],
                          selectedItemText: ctrl.category,
                          onSelected: (selectedItem) {
                           ctrl.category=selectedItem ?? 'general';
                           ctrl.update();
                          },)),
                    Flexible(child: DropDownBttn(
                      items: ['Apex', 'Lotto', 'Bata','Nike'],
                      selectedItemText: ctrl.brand,
                      onSelected: (
                        selectedItem) {
                        ctrl.brand=selectedItem ?? 'Non Brand';
                        ctrl.update();
                    },)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Offer Product?'),
                DropDownBttn(
                  items: ['true', 'false'],
                  selectedItemText: ctrl.offer.toString(),
                  onSelected: (selectedItem) {
                    ctrl.offer=bool.tryParse(selectedItem!)!;
                    ctrl.update();
                  },),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: () {
                  if (ctrl.productName.text.isNotEmpty &&
                      ctrl.productDescription.text.isNotEmpty &&
                      ctrl.productImgUrl.text.isNotEmpty &&
                      ctrl.productPrice.text.isNotEmpty &&
                      ctrl.category != null &&
                      ctrl.brand != null &&
                      ctrl.offer != null) {
                    ctrl.addProduct();
                    ctrl.emptyDataset();
                  }else{
                    Get.snackbar('Null error', 'Kindly filled up all TextField',colorText: Colors.deepOrange);

                  }
                }, child: Text('Add Product'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
