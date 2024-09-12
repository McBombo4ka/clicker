// import 'package:clicker/json_decoder.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Map<String, dynamic> _items = {};

class Clicker extends StatelessWidget {
  const Clicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height,
        child: UnconstrainedBox(
          child: Container(
            color: Colors.red,
            width: 200,
            height: 200,
            alignment: Alignment.center,
          ),
        ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height,
          child: const ListOfAnimeGirls())
    ]));
  }
}

class ListOfAnimeGirls extends StatefulWidget {
  const ListOfAnimeGirls({super.key});

  @override
  State<ListOfAnimeGirls> createState() => _ListOfAnimeGirlsState();
}

class _ListOfAnimeGirlsState extends State<ListOfAnimeGirls> {
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/model.json");
    final Map<String, dynamic> data = await jsonDecode(response);
    print("Data from JSON: $data");
    setState(() {
      _items = data["hutao"];
      print(_items["name"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ElevatedButton(
            onPressed: () {
              readJson();
            },
            child: Text('Press'),
          ),
        ),
        _items.isNotEmpty
            ? Expanded(
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 227, 69),
                          border: Border.all(
                              color: const Color.fromARGB(255, 59, 59, 59))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_items["name"]),
                          Text(_items["stats"]["power"]),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.40 *
                                      0.8,
                                  top: MediaQuery.of(context).size.height * 0.02),
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    readJson();
                                  },
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(
                                        const Size(80, 30)),
                                  ),
                                  child: const Text('data'),
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                ),
            )
            // ignore: avoid_unnecessary_containers
            : Container(
                child: const Text("Items has no data."),
              ),
      ],
    );
  }
}
