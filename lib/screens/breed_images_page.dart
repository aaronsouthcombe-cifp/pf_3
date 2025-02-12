import 'package:flutter/material.dart';
import '../services/dog_service.dart';
import '../models/dog_images.dart';

class BreedImagesPage extends StatefulWidget {
  final String breed;
  BreedImagesPage({required this.breed});
  @override
  _BreedImagesPageState createState() => _BreedImagesPageState();
}

class _BreedImagesPageState extends State<BreedImagesPage> {
  late Future<DogImages> _futureImages;

  @override
  void initState() {
    super.initState();
    _futureImages = DogService.getImagesByBreed(widget.breed);
  }

  @override
  Widget build(BuildContext context) {
    String displayBreed =
        widget.breed[0].toUpperCase() + widget.breed.substring(1).toLowerCase();
    return Scaffold(
      appBar: AppBar(title: Text("$displayBreed Images")),
      body: FutureBuilder<DogImages>(
        future: _futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.message.isEmpty)
            return Center(child: Text('No images found'));
          List<String> images = snapshot.data!.message;
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

