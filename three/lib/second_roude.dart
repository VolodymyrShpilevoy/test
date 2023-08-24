import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final List<String> selectedItems;

  const SecondRoute({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: selectedItems.map((item) => Text(item, style: TextStyle(fontSize: 16))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
