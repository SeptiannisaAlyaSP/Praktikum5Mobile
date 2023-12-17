import 'package:ICE_CREAM_APP/controller/acc_controller.dart';
import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AccountController acc = Get.put(AccountController());

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  final Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('656ebf8ae2606f2bcde2');

  final Collection collection = Collection('Toppings').setClient(client);

  RxList<IceCream> iceCreams = <IceCream>[].obs;

  Future<void> registerAppwrite(
      String email, String password, String name) async {
    try {
      isLoading.value = true;
      final result = await acc.createAccount({
        'userId': ID.unique(),
        'email': email,
        'password': password,
        'name': name,
      });
      print(result);
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(LoginPage());
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginAppwrite(String email, String password) async {
    try {
      isLoading.value = true;
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      Get.off(HomePage());
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    Get.off(LoginPage());
  }

  // Operasi CRUD
  Future<void> addIceCream(
      String flavor, String description, double price) async {
    try {
      isLoading.value = true;
      final response = await collection.createDocument(
        data: {'flavor': flavor, 'description': description, 'price': price},
      );
      final newIceCream = IceCream(
          id: response['\$id'],
          flavor: flavor,
          description: description,
          price: price);
      iceCreams.add(newIceCream);
      Get.snackbar('Success', 'Ice cream added successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to add ice cream: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> listIceCreams() async {
    try {
      isLoading.value = true;
      final response = await collection.listDocuments();
      iceCreams.value = response['documents']
          .map((doc) => IceCream(
                id: doc['\$id'],
                flavor: doc['flavor'],
                description: doc['description'],
                price: doc['price'],
              ))
          .toList();
    } catch (error) {
      Get.snackbar('Error', 'Failed to retrieve ice creams: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateIceCream(String id, String newFlavor,
      String newDescription, double newPrice) async {
    try {
      isLoading.value = true;
      await collection.updateDocument(documentId: id, data: {
        'flavor': newFlavor,
        'description': newDescription,
        'price': newPrice
      });
      final index = iceCreams.indexWhere((iceCream) => iceCream.id == id);
      if (index != -1) {
        iceCreams[index].flavor = newFlavor;
        iceCreams[index].description = newDescription;
        iceCreams[index].price = newPrice;
      }
      Get.snackbar('Success', 'Ice cream updated successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to update ice cream: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteIceCream(String id) async {
    try {
      isLoading.value = true;
      await collection.deleteDocument(documentId: id);
      iceCreams.removeWhere((iceCream) => iceCream.id == id);
      Get.snackbar('Success', 'Ice cream deleted successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete ice cream: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}

class IceCream {
  String id;
  String flavor;
  String description;
  double price;

  IceCream(
      {required this.id,
      required this.flavor,
      required this.description,
      required this.price});
}
