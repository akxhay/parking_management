// String host = "297e-27-58-16-135.in.ngrok.io";
String host = "192.168.1.8:8080";
Duration defaultTimeout = const Duration(seconds: 5);

class ApiConstants {
  static String getHost() {
    return host;
  }

  static String parkingLot() {
    return "${getHost()}/parking/lot/";
  }

  static String deleteParkingLot() {
    return "${parkingLot()}v1/delete/";
  }

  static String fetchParkingLot() {
    return "${parkingLot()}v1/fetch-all/";
  }

  static String createParkingLot() {
    return "${parkingLot()}v1/create/";
  }

  static String pexelsBaseUrl = "www.pexels.com";

  static getWebSocketUrl() {}

  // static Future<int> getClient() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   int? client = pref.getInt("client");
  //   if (client == null) {
  //     client = DateTime.now().millisecondsSinceEpoch;
  //     pref.setInt("client", client);
  //   }
  //   debugPrint("client: $client");
  //   return client;
  // }

  // static void setHost(host) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString("host", host);
  // }

  // static Future<String> getWebSocketUrl() async {
  //   return "ws://${await getHost()}/ws/${await getClient()}";
  // }

  // static Future<String> getBaseUrl() async {
  //   return "http://${await getHost()}/item/";
  // }

  // static Future<String> getConfigUrl() async {
  //   return "http://${await getHost()}/config/";
  // }

  // static Future<String> getMediaUrl() async {
  //   return "http://${await getHost()}/media/";
  // }

  // static Future<String> getChatGptUrl() async {
  //   return "http://${await getHost()}/chat-gpt/";
  // }

  // static Future<String> getMusicUrl() async {
  //   return "${await getMediaUrl()}music/";
  // }

  // static Future<String> getDummyMusicUrl() async {
  //   return "${await getMusicUrl()}dummy/";
  // }

  // static Future<String> getUploadUrl() async {
  //   return "${await getMediaUrl()}upload/";
  // }

  // static Future<String> getVideoUrl() async {
  //   return "${await getMediaUrl()}video/";
  // }

  // static Future<String> getImageUrl() async {
  //   return "${await getMediaUrl()}image/";
  // }

  // static Future<String> getGptContentUrl() async {
  //   return "${await getChatGptUrl()}content/";
  // }

  // static Future<String> getGptTitleUrl() async {
  //   return "${await getChatGptUrl()}title/";
  // }

  // static Future<String> getGptDescriptionUrl() async {
  //   return "${await getChatGptUrl()}description/";
  // }

  // static Future<String> getGptKeywordUrl() async {
  //   return "${await getChatGptUrl()}keyword/";
  // }

  // static Future<Map<String, String>> getCommonHeaders() async {
  //   return {
  //     HttpHeaders.contentTypeHeader: "application/json",
  //     "clientId": (await ApiConstants.getClient()).toString()
  //   };
  // }
}
