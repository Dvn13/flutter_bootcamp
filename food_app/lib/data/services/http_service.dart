import 'dart:convert';
import 'dart:io';

import 'package:food_app/data/entity/foods_cart_model.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/result_model.dart';
import 'package:food_app/data/services/path.dart';
import 'package:http/http.dart' as http;

class HttpManager {
  HttpManager();

  Future<ResultModel> addCart({
    required String path,
    required FoodCartPostModel foodCartPostModel,
  }) async {
    var uri = Uri.parse('${NetworkRoute.baseUrl}$path');
    var request = http.MultipartRequest('POST', uri);

    var model = foodCartPostModel.toJson();
    model.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final result = json.decode(response.body);
      return ResultModel.fromJson(result);
    } catch (error) {
      rethrow;
    }
  }

  Future<FoodCartModel> getCart({
    required String path,
    required String kullaniciAdi,
  }) async {
    var uri = Uri.parse('${NetworkRoute.baseUrl}$path');
    var request = http.MultipartRequest('POST', uri);

    request.fields['kullanici_adi'] = kullaniciAdi;

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final result = json.decode(response.body);
          return FoodCartModel.fromJson(result);
        } else {
          return FoodCartModel();
        }
      } else {
        throw Exception('HTTP ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      return FoodCartModel();
    }
  }

  Future<ResultModel> deleteFoodCart({
    required String path,
    required String kullaniciAdi,
    required int sepetYemekId,
  }) async {
    var uri = Uri.parse('${NetworkRoute.baseUrl}$path');
    var request = http.MultipartRequest('POST', uri);

    request.fields['kullanici_adi'] = kullaniciAdi;
    request.fields['sepet_yemek_id'] = sepetYemekId.toString();

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final result = json.decode(response.body);
      return ResultModel.fromJson(result);
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await http.get(
        Uri.parse('${NetworkRoute.baseUrl}$path'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      final result = json.decode(response.body) as Map<String, dynamic>;

      return result;
    } catch (error) {
      rethrow;
    }
  }
}
