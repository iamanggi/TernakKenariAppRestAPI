import 'dart:convert';

import 'package:canary/data/model/request/admin/anak_request_model.dart';
import 'package:canary/data/model/response/get_all_anak_response.dart';
import 'package:canary/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class AnakRepository {
  final ServiceHttpClient _serviceHttpClient;

  AnakRepository(this._serviceHttpClient);

  Future<Either<String, GetAnakById>> addAnak(
    AnakRequestModel requestModel,
  ) async {
    try{
      final response = await _serviceHttpClient.postWithToken(
        'admin/anak',
        requestModel.toJson(),
      );
      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAnakById.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error ocurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e ");
    }
  }

  Future<Either<String, GetAllAnakModel>> getAllAnak() async {
    try{
      final response = await _serviceHttpClient.get('admin/anak');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAllAnakModel.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error ocurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e ");
}
    }
  }
