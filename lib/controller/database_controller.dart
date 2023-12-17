import 'package:ICE_CREAM_APP/controller/client_controller.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
// appwrite
    databases = Databases(client);
  }

  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "656fe37b5bf1fa2e2c34",
        documentId: ID.unique(),
        collectionId: "656fe386abe885e030c2",
        data: map,
        permissions: [
          Permission.read(Role.user("USERID")),
          Permission.update(Role.user("USERID")),
          Permission.delete(Role.user("USERID")),
        ],
      );
      print("DatabaseController:: storeUserName $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
