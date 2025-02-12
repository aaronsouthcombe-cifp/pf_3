
import 'package:flutter/material.dart';
import '../services/dog_service.dart';
import '../models/dog_images.dart';

class CardSwiper extends StatelessWidget {
  final int imageCount;
  const CardSwiper({Key? key, required this.imageCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DogImages>(
        future: DogService.getRandomImages(imageCount),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.message.isEmpty)
            return Center(child: Text('No images available'));
          List<String> images = snapshot.data!.message;
          return PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                child: Image.network(images[index], fit: BoxFit.cover),
              );
            },
          );
        },
      ),
    );
  }
}

