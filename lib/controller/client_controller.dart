import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  Client client = Client();
  late final Storage storage;

  @override
  void onInit() {
    super.onInit();
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "656ebf8ae2606f2bcde2";
    client
        .setEndpoint(endPoint)
        .setProject(projectID)
        .setSelfSigned(status: true);

    // Inisialisasi Appwrite di sini
    initializeAppwrite();
  }

  void initializeAppwrite() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('656ebf8ae2606f2bcde2'); // Your Appwrite Project ID

    // Inisialisasi Storage
    storage = Storage(client);
  }
}
