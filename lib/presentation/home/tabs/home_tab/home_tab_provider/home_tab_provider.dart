import 'package:evently/models/event_model.dart';
import 'package:evently/services/events_service.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  EventsProvider() {
    getEvents();
  }

  List<EventModel> events = [];
  List<EventModel> favEvent = [];
  bool isLoading = false;
  String? errorMessage;
  bool isLoadingFav = false;
  String? errorMessageFav;

  Future<void> getFavEvent() async {
    isLoadingFav = true;
    notifyListeners();
    favEvent = await EventsService.getAllFav();

    isLoadingFav = false;
    notifyListeners();
  }

  Future getEvents() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();
    try {
      events = await EventsService.getAllEvent() ?? [];
    } on Exception catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void updateEvent(EventModel event) {
    for (var i = 0; i < events.length; i++) {
      if (events[i].id == event.id) {
        events[i] = event;
      }
    }
    for (var i = 0; i < favEvent.length; i++) {
      if (favEvent[i].id == event.id) {
        favEvent[i] = event;
      }
    }
    notifyListeners();
  }
}
