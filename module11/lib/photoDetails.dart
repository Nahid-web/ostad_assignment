import 'package:flutter/material.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({
    super.key,
    required this.photo});

  final Map<String, dynamic> photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photo["url"]),
            const SizedBox(height: 10,),
            Text('Title: ${photo["title"]}'),
            const SizedBox(height: 10,),
            Text('Id: ${photo["id"]}'),
          ],
        ),
      ),
    );
  }
}
