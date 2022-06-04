import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fetch_v2/models/album_model.dart';
import 'package:flutter_fetch_v2/view_models/album_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Album>>? futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbumData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("flutter fetch v2")),
        body: FutureBuilder(
          future: futureAlbums,
          builder: (context, AsyncSnapshot<List<Album>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, int i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        child: Center(child: Text(snapshot.data![i].title)),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}
