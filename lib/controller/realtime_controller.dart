import 'package:ICE_CREAM_APP/controller/client_controller.dart';
import 'package:appwrite/appwrite.dart';

class RealtimeController extends ClientController {
  Realtime? realtime;
  @override
  void onInit() {
    super.onInit();
// appwrite
    realtime = Realtime(client);
  }

  subsUserName() async {
    final subscription = realtime!.subscribe(['files']);
    subscription.stream.listen((response) {
      if (response.events.contains('buckets.*.files.*.create')) {
        print("RealtimeController:: subsUserName ${response.payload}");
        print("RealtimeController:: subsUserName ${response.events}");
      }
    });
  }
}
