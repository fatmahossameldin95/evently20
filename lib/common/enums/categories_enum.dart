import 'package:evently/gen/assets.gen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum CategoriesEnum {
  birthDays(title: "BirthDays"),
  books(title: "Books"),
  sports(title: "Sports"),
  exhibition(title: "Exhibition");

  final String title;

  const CategoriesEnum({required this.title});
  String toJson() {
    return title;
  }

  String getTitle(context) {
    switch (this) {
      case CategoriesEnum.birthDays:
        return AppLocalizations.of(context)!.birthDay;
      case CategoriesEnum.books:
        return AppLocalizations.of(context)!.book;

      case CategoriesEnum.sports:
        return AppLocalizations.of(context)!.sports;

      case CategoriesEnum.exhibition:
        return AppLocalizations.of(context)!.exhibition;
    }
  }

  static CategoriesEnum fromJson(String jsonName) {
    for (var i = 0; i < CategoriesEnum.values.length; i++) {
      if (CategoriesEnum.values[i].title == jsonName) {
        return CategoriesEnum.values[i];
      }
    }
    return CategoriesEnum.birthDays;
  }

  String get getImage {
    switch (this) {
      case CategoriesEnum.birthDays:
        return Assets.images.birthday.path;
      case CategoriesEnum.books:
        return Assets.images.bookClub.path;

      case CategoriesEnum.sports:
        return Assets.images.sports.path;

      case CategoriesEnum.exhibition:
        return Assets.images.exhibition.path;
    }
  }

  IconData get getIcon {
    switch (this) {
      case CategoriesEnum.birthDays:
        return Icons.cake_outlined;
      case CategoriesEnum.books:
        return Icons.menu_book;

      case CategoriesEnum.sports:
        return Icons.directions_bike;

      case CategoriesEnum.exhibition:
        return Icons.art_track;
    }
  }
}

test() {
  CategoriesEnum enumvalue = CategoriesEnum.sports;
}
