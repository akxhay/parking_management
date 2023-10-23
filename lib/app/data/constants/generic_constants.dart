


class GenericConstants {
  static int parkingPricePerHour = 100;

  static String parkingDateFormat = "dd MMM yyyy";
  static String parkingTimeFormat = "h:mm a";

  static String host = "192.168.1.8:8080";
  static Duration defaultTimeout = const Duration(seconds: 5);

  static final Map<String, String> carTypes = {
    "s": "Small",
    "m": "Medium",
    "l": "Large",
    "xl": "Extra Large",
  };
}
