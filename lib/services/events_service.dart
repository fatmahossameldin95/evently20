import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventsService {
  static CollectionReference<EventModel> _getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection("events")
        .withConverter(
          fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data() ?? {}),
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
        .where("favorites", arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  //add event

  //delete event

  //get all events

  //get fav events

  //add/remove from fav
}
