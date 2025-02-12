class DogImages {
  final List<String> message;
  final String status;
  DogImages({required this.message, required this.status});
  factory DogImages.fromJson(Map<String, dynamic> json) {
    return DogImages(message: List<String>.from(json["message"]), status: json["status"]);
  }
}

