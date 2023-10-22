import 'dart:developer';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ParkingRepository {
  Future<http.Response> fetchItems(int page, int size) async {
    var queryString = {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
    };
    String host = ApiConstants.getHost();
    final Uri url = Uri.http(host, "/parking/lot/v1/fetch-all", queryString);

    log(url.toString());
    return await http.get(url).timeout(defaultTimeout);
  }

  Future<http.Response> deleteItem(id) async {
    String host = ApiConstants.getHost();
    final Uri url = Uri.http(host, "/parking/lot/v1/delete/$id");

    log(url.toString());
    return await http.delete(url);
  }

  Future<http.Response> createItem(item) async {
    String host = ApiConstants.getHost();
    final Uri url = Uri.http(host, "/item/");
    return await http.post(url);
  }

  Future<http.Response> getSlot(parkingId, size) async {
    String host = ApiConstants.getHost();
    final Uri url = Uri.http(host, "/parking/getslot/$parkingId/$size");

    log(url.toString());
    return await http.get(url);
  }

  Future<http.Response> releaseSlot(parkingId, slotId) async {
    String host = ApiConstants.getHost();
    final Uri url = Uri.http(host, "/parking/releaseslot/$parkingId/$slotId");
    return await http.put(url);
  }
}
