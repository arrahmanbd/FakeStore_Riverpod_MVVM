import '../helper/exception.dart';
import '../utils/toast.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      print(message);
      // DialogHelper.showErroDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      print(message);
      // DialogHelper.showErroDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      // DialogHelper.showErroDialog(
      //     description: 'Oops! It took longer to respond.');
    }
  }

  showLoading([String? message]) {
    // DialogHelper.showLoading(message);
  }

  hideLoading() {
    // DialogHelper.hideLoading();
  }
}
