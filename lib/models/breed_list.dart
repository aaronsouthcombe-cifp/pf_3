class BreedList {
  final Map<String, List<String>> message;
  final String status;
  BreedList({required this.message, required this.status});
  factory BreedList.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> breeds = {};
    json["message"].forEach((key, value) {
      breeds[key] = List<String>.from(value);
    });
    return BreedList(message: breeds, status: json["status"]);
  }
}

