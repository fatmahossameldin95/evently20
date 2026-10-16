import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventsService {
  static CollectionReference<EventModel> _getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection("events")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  static Future<void> addEvent(EventModel event) async {
    try {
      CollectionReference<EventModel> collection = _getEventsCollection();
      DocumentReference<EventModel> doc = collection.doc();
      event.id = doc.id;
      await doc.set(event);
    } on Exception catch (e) {
      print('ERROR-->$e');
      throw "something went wrong";
    }
  }

  static Future<List<EventModel>?> getAllEvent() async {
    try {
      CollectionReference<EventModel> collection = _getEventsCollection();
      QuerySnapshot<EventModel> snapshot = await collection.get();
      List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
      return events;
    } on Exception catch (e) {
      // TODO
      print('ERROR--->$e');
      throw "something went wrong";
    }
  }

  static Future updateFav(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    DocumentReference<EventModel> doc = collection.doc(event.id);
    await doc.update(event.updateFav());
  }

  static Future<List<EventModel>> getAllFav() async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection
        .where(
          "favorites",
          arrayContains: FirebaseAuth.instance.currentUser?.uid,
        )
        .get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future<void> editEvent(EventModel event) async {
    try {
      if (event.id == null || event.id!.isEmpty) {
        throw Exception('Event ID is required for editing');
      }

      final CollectionReference<EventModel> collection = _getEventsCollection();

      final DocumentReference<EventModel> doc = collection.doc(event.id);

      await doc.set(event, SetOptions(merge: true));
    } catch (e) {
      debugPrint('EDIT EVENT ERROR --> $e');
      throw Exception('Something went wrong while editing the event');
    }
  }

  static Future<void> deleteEvent(String eventId) async {
    try {
      if (eventId.trim().isEmpty) {
        throw Exception('Event ID is required');
      }

      final collection = _getEventsCollection();
      await collection.doc(eventId).delete();
    } catch (e) {
      debugPrint('DELETE EVENT ERROR --> $e');
      rethrow;
    }
  }


}
