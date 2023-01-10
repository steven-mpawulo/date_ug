import 'dart:io';

class CheckInternetConnectivity {
  Future checkInternetConnection() async {
    try {
      dynamic result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return result;
      } else {
        return null;
      }
    } catch (e) {
      print("Something went wrong");
    }
  }
}
