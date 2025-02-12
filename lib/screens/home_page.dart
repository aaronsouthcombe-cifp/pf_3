
import 'package:flutter/material.dart';
import '../widgets/card_swiper.dart';
import '../widgets/image_slider.dart';
import '../services/dog_service.dart';
import '../models/breed_list.dart';
import 'breed_images_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> breeds = [];
  List<String> filteredBreeds = [];
  bool loadingBreeds = true;
  TextEditingController controller = TextEditingController();
  double sliderValue = 5;

  @override
  void initState() {
    super.initState();
    loadBreeds();
  }

  void loadBreeds() async {
    BreedList breedList = await DogService.getBreedsList();
    List<String> breedNames = breedList.message.keys.toList();
    setState(() {
      breeds = breedNames;
      filteredBreeds = breedNames;
      loadingBreeds = false;
    });
  }

  void filterBreeds(String query) {
    List<String> list = breeds
        .where((breed) => breed.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredBreeds = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dog Gallery")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: CardSwiper(imageCount: sliderValue.toInt()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text("Number of Images: ${sliderValue.toInt()}"),
                  Slider(
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: sliderValue.toInt().toString(),
                    value: sliderValue,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ImageSlider(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                onChanged: filterBreeds,
                decoration: InputDecoration(
                  hintText: "Search Breeds",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            loadingBreeds
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredBreeds.length,
                    itemBuilder: (context, index) {
                      String breed = filteredBreeds[index];
                      return ListTile(
                        title: Text(breed[0].toUpperCase() +
                            breed.substring(1).toLowerCase()),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BreedImagesPage(breed: breed),
                            ),
                          );
                        },
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

