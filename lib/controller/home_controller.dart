import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
class HomeController extends GetxController{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  TextEditingController productName=TextEditingController();
  TextEditingController productDescription=TextEditingController();
  TextEditingController productPrice=TextEditingController();
  TextEditingController productImgUrl=TextEditingController();

  String category = 'general';
  String brand = 'Non brand';
  bool offer = false;

  List<Product> products=[];

  @override
  Future<void> onInit() async{
    productCollection=firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }
  addProduct(){
    try {
      double? price = double.tryParse(productPrice.text);
      DocumentReference doc=productCollection.doc();
      Product product= Product(
            id:doc.id,
            name:productName.text,
            category: category,
            description: productDescription.text,
            price: price,
            brand: brand,
            image: productImgUrl.text,
            offer: true,
          );
      final productJson=product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added successfully',colorText: Colors.deepOrange);
    } catch (e) {
      Get.snackbar('Error', e.toString(),colorText: Colors.deepOrange);
      print(e);
    }
  }

  fetchProducts() async{
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrieveProducts = productSnapshot.docs.map((doc) =>
              Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrieveProducts);
    } catch (e) {
       Get.snackbar('Error', e.toString());
    }finally{
      update();
    }
  }

  deleteProduct(String id) async{
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  emptyDataset(){
    productName.clear();
    productDescription.clear();
    productPrice.clear();
    productImgUrl.clear();

    category='general';
    brand = 'Non brand';
    offer=false;
    update();

  }
}