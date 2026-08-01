import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/config/theme/app_strings.dart';
import 'package:event_app/modules/data/category_data.dart';

class FireBaseServices {
  final db = FirebaseFirestore.instance;
  CollectionReference<CategoryData> _getCategoryData() {
    return db
        .collection(AppStrings.eventAppCollectionName)
        .withConverter<CategoryData>(
          fromFirestore: (snapshot, options) {
            return CategoryData.fromFirestore(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );
  }
  Stream<List<CategoryData>> getCategoryDataStream() {

    return _getCategoryData().snapshots().map((snapshot) {
      List<CategoryData> categoryData = [];

      for (var doc in snapshot.docs) {
        categoryData.add(doc.data());
      }

      return categoryData;
    });
  }
  Stream<QuerySnapshot<CategoryData>> getRealTime(String eventID){

    final collectionRef=_getCategoryData().where("eventID",isEqualTo: eventID);
    return collectionRef.snapshots();
  }
  Future<void> createNewEvent(CategoryData category) async {
    var docRef = _getCategoryData().doc();
    category.categoryID = docRef.id;
    docRef.set(category);
  }

}
