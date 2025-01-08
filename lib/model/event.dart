class Event {
  static const String collectionName = 'Events';
  String id;
  String eventName;
  String image;
  String title;
  String description;
  DateTime dateTime;
  String time;
  bool isFavourite;

  Event(
      {this.id = '',
      required this.eventName,
      required this.image,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.time,
      this.isFavourite = false});

  // create function to convert Map to object (json => object)
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          eventName: data['eventName'] as String,
          image: data['image'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          time: data['time'] as String,
          isFavourite: data['isFavourite'] as bool,
        );

  // create function to convert object to Map (object => json)
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'eventName': eventName,
      'image': image,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavourite': isFavourite
    };
  }
}
