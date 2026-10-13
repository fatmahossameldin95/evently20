import 'package:evently/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum OnboardingEnum {
  events(
    header: "Find Events That Inspire You",
    description:
        "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
  ),
  manage(
    header: "Effortless Event Planning",
    description:
        "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
  ),
  connect(
    header: "Connect with Friends & Share Moments",
    description:
        "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
  );

  final String header;
  final String description;
  const OnboardingEnum({required this.header, required this.description});

  // String getHeader(context) {
  //   switch (this) {
  //     case OnboardingEnum.events:
  //       return AppLocalizations.of(context)!.findEvents;
  //     case OnboardingEnum.planning:
  //       return AppLocalizations.of(context)!.effortlessPlanning;
  //     case OnboardingEnum.connect:
  //       return AppLocalizations.of(context)!.connectWithFriends;
  //   }
  // }
  String getHeader() {
    return header;
  }

  String getDescription() {
    return description;
  }

  String getImage(ThemeMode themeMode) {
    final isDark = themeMode == ThemeMode.dark;

    switch (this) {
      case OnboardingEnum.events:
        return isDark
            ? Assets.images.eventsDark.path
            : Assets.images.events.path;

      case OnboardingEnum.manage:
        return isDark
            ? Assets.images.manageDark.path
            : Assets.images.manage.path;

      case OnboardingEnum.connect:
        return isDark
            ? Assets.images.connectDark.path
            : Assets.images.connect.path;
    }
  }
}
