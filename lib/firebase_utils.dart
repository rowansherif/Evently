import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, options) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event) {
    var collection = getEventCollection();
    var document = collection.doc();
    event.id = document.id;
    return document.set(event);
  }
}
