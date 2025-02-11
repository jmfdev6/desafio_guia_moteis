import 'dart:convert';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalCache {
  static const String boxName = 'moteisBox';
  static LocalCache? _instance;
  Box<String>? _box;

  LocalCache._internal();

  static LocalCache get instance {
    _instance ??= LocalCache._internal();
    return _instance!;
  }

  Future<void> _openBox() async {
    _box ??= await Hive.openBox<String>(boxName);
  }

  Future<void> cacheMoteis(MoteisModel model) async {
    await _openBox();
    try {
      String jsonString = jsonEncode(model.toJson());
      await _box!.put('cachedMoteis', jsonString);
    } catch (e) {
      print('Erro ao armazenar em cache: $e');
    }
  }

  Future<MoteisModel?> getCachedMoteis() async {
    await _openBox();
    try {
      String? jsonString = _box!.get('cachedMoteis');
      if (jsonString != null) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return MoteisModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      print('Erro ao recuperar do cache: $e');
      return null;
    }
  }
}