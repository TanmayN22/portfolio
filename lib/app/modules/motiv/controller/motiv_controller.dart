import 'package:get/get.dart';
import 'package:porfolio/app/modules/motiv/services/motiv_services.dart';

class MotivController extends GetxController {
  // Observable for notification state
  var currentNotification = Rx<String?>(null);

  // Track if notification is currently showing
  bool get isNotificationShowing => currentNotification.value != null;

  void showRandomQuote() {
    // Only show new quote if no notification is currently showing
    if (!isNotificationShowing) {
      final quote = MotivService.getRandomQuote();
      currentNotification.value = quote;
    }
    // If notification is already showing, do nothing (ignore the click)
  }

  void dismissNotification() {
    currentNotification.value = null;
  }
}
