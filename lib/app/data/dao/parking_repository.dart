import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking/app/data/dto/request_dto.dart';

import '../constants/generic_constants.dart';

class ParkingRepository {
  Future<http.Response> fetchItems(int page, int size) async {
    var queryString = {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
    };
    final Uri url =
        Uri.http(GenericConstants.host, "/parking/lot", queryString);

    log(url.toString());
    return await http.get(url).timeout(GenericConstants.defaultTimeout);
  }

  Future<http.Response> deleteItem(id) async {
    final Uri url = Uri.http(GenericConstants.host, "/parking/lot/$id");

    log(url.toString());
    return await http.delete(url);
  }

  Future<http.Response> createItem(
      ParkingLotRequestDto parkingLotRequestDto) async {
    final Uri url = Uri.http(GenericConstants.host, "/parking/lot");
    log(url.toString());

    String jsonString = convert.jsonEncode(parkingLotRequestDto.toMap());

    return await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonString);
  }

  Future<http.Response> getSlot(parkingId, size, numberPlate) async {
    final Uri url =
        Uri.http(GenericConstants.host, "/parking/getslot/$parkingId/$size");

    log(url.toString());
    return await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'number-plate': numberPlate,
      'arrived-at': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  Future<http.Response> releaseSlot(parkingId, slotId) async {
    final Uri url = Uri.http(
        GenericConstants.host, "/parking/releaseslot/$parkingId/$slotId");
    return await http.put(url);
  }
}
