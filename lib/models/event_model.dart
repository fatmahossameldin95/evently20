import 'package:evently/common/enums/categories_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String title;
  String description;
  int date;
  CategoriesEnum categoriesEnum;
  String? id;
  List<String>? favorites;
  EventModel({
    required this.categoriesEnum,
    required this.date,
    required this.description,
    this.id,
    this.favorites,
    required this.title,
  });
  DateTime get dateValu => DateTime.fromMicrosecondsSinceEpoch(date);
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "category": categoriesEnum.toJson(),
      "date": date,
      "favorites": favorites,
    };
  }

  Map<String, dynamic> updateFav() {
    return {"favorites": favorites};
  }

  bool get isFav => (favorites ?? []).contains(FirebaseAuth.instance.currentUser?.uid);
  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      categoriesEnum: CategoriesEnum.fromJson(json['category']),
      date: json['date'],
      description: json['description'],
      title: json['title'],
      favorites: List<String>.from(
        json['favorites'] ?? [],
      ), // (json['favorites']??[]).cast<String>(),
      id: json['id'],
    );
  }
}
