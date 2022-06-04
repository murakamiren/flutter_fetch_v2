import 'dart:convert';

import 'package:flutter_fetch_v2/models/album_model.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbumData() async {
  const apiUrl = "https://jsonplaceholder.typicode.com/albums";

  final res = await http.get(Uri.parse(apiUrl));

  if (res.statusCode == 200) {
    final decodedData = await jsonDecode(res.body);
    final List<Album> albums =
        await decodedData.map<Album>((data) => Album.fromJson(data)).toList();
    return albums;
  } else {
    throw Exception("error");
  }
}
