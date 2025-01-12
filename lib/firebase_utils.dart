import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/model/event.dart';
import 'package:events_app/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, _) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, _) => event.toFireStore());
    // return FirebaseFirestore.instance
    //     .collection(Event.collectionName)
    //     .withConverter<Event>(
    //         fromFirestore: (snapshot, options) =>
    //             Event.fromFireStore(snapshot.data()!),
    //         toFirestore: (event, options) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    var collection = getEventCollection(uId);
    var document = collection.doc();
    event.id = document.id;
    return document.set(event);
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (myUser, _) => myUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    // var collection = getUserCollection();
    // var document = collection.doc(myUser.id);
    // return document.set(myUser);
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }
}
