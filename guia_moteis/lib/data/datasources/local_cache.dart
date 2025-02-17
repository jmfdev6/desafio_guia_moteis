import 'dart:convert';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:hive/hive.dart';
class LocalCache {
  static const String boxName = 'moteisBox';
  /// Armazena os dados do modelo no Hive.
  Future<void> cacheMoteis(MoteisModel model) async {
    final box = await Hive.openBox(boxName);
    String jsonString = jsonEncode(model.toJson());
    await box.put('cachedMoteis', jsonString);
  }
  /// Recupera os dados do cache e os converte para o modelo.
  Future<MoteisModel?> getCachedMoteis() async {
    final box = await Hive.openBox(boxName);
    String? jsonString = box.get('cachedMoteis');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return MoteisModel.fromJson(jsonMap);
    }
    return null;
  }
}