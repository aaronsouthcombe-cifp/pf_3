import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/breed_list.dart';
import '../models/dog_image.dart';
import '../models/dog_images.dart';

class DogService {
  static const String baseUrl = "https://dog.ceo/api";
  static Future<BreedList> getBreedsList() async {
    var url = Uri.parse("$baseUrl/breeds/list/all");
    var res = await http.get(url);
    return BreedList.fromJson(json.decode(res.body));
  }
  static Future<DogImage> getRandomImage() async {
    var url = Uri.parse("$baseUrl/breeds/image/random");
    var res = await http.get(url);
    return DogImage.fromJson(json.decode(res.body));
  }
  static Future<DogImages> getRandomImages(int count) async {
    if (count > 10) count = 10;
    var url = Uri.parse("$baseUrl/breeds/image/random/$count");
    var res = await http.get(url);
    return DogImages.fromJson(json.decode(res.body));
  }
  static Future<DogImages> getImagesByBreed(String breed) async {
    var url = Uri.parse("$baseUrl/breed/$breed/images");
    var res = await http.get(url);
    return DogImages.fromJson(json.decode(res.body));
  }
  static Future<DogImage> getRandomImageByBreed(String breed) async {
    var url = Uri.parse("$baseUrl/breed/$breed/images/random");
    var res = await http.get(url);
    return DogImage.fromJson(json.decode(res.body));
  }
  static Future<List<String>> getSubBreeds(String breed) async {
    var url = Uri.parse("$baseUrl/breed/$breed/list");
    var res = await http.get(url);
    return List<String>.from(json.decode(res.body)["message"]);
  }
  static Future<DogImages> getSubBreedImages(String breed, String subBreed) async {
    var url = Uri.parse("$baseUrl/breed/$breed/$subBreed/images");
    var res = await http.get(url);
    return DogImages.fromJson(json.decode(res.body));
  }
}

