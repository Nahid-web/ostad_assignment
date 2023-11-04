import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:module11/photoDetails.dart';

class PhotoGalleryHomePage extends StatefulWidget {
  const PhotoGalleryHomePage({super.key});

  @override
  State<PhotoGalleryHomePage> createState() => _PhotoGalleryHomePageState();
}

class _PhotoGalleryHomePageState extends State<PhotoGalleryHomePage> {
  List<Map<String, dynamic>> photoGalleryList = [];

  Future getPhotoGallery() async {
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if (response.statusCode == 200) {
      final photoGalleryJson = jsonDecode(response.body);
      photoGalleryJson.forEach((element) {
        photoGalleryList.add(element);
      });
      setState(() {});
    }
    else if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something error , please correct the issue'),
        ),
      );
    }

  }

  @override
  void initState() {
    getPhotoGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: ListView.builder(
        itemCount: photoGalleryList.length,
        itemBuilder: (context, index) {
          final currentPhoto = photoGalleryList[index];
          final title = currentPhoto["title"];
          final thumbnailUrl = currentPhoto["thumbnailUrl"];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(title),
              leading: Image.network(thumbnailUrl),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoDetails(photo: currentPhoto,),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
