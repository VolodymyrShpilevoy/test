import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "second_roude.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items = [];
  List<String> selectedItems = [];

  @override
  void initState() {
    refreshUsers();
    super.initState();
  }

  Future refreshUsers() async {
    Uri uri = Uri.parse("https://64e5eb1f09e64530d17f40a9.mockapi.io/products");
    final response = await http.get(uri);
    var data = json.decode(response.body);
    items = [];
    setState(() {
      for (var i = 0; i < data.length; i++) {
        items.add(data[i]["name"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Shop",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              child: const Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute(selectedItems: selectedItems)),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromARGB(255, 22, 22, 22),
        child: RefreshIndicator(
          onRefresh: refreshUsers,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: selectedItems.contains(items[index]),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedItems.add(items[index]);
                        print(selectedItems);
                      } else {
                        selectedItems.remove(items[index]);
                        print(selectedItems);
                      }
                    });
                  },
                ),
                title: Text(
                  "${items[index]}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
