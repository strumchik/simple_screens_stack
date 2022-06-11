import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Message'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://source.unsplash.com/random/450x450'),
                  fit: BoxFit.cover,
                ),
                backgroundBlendMode: BlendMode.difference,
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Text(
                "Simple image description",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
