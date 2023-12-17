import 'package:ICE_CREAM_APP/controller/client_controller.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageController extends ClientController {
  Storage? storages;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi Appwrite Storage
    storages = Storage(client);
  }

  Future<void> storeImage() async {
    try {
      final result = await storages!.createFile(
        bucketId: '656fe402495a5e1a4931', // Ganti dengan ID bucket sesungguhnya
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: './path-to-files/image.jpg',
          filename: 'image.jpg',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.dialog(
        AlertDialog(
          title: Text("Error Storage"),
          content: Text(
            "$error",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
