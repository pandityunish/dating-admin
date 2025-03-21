// import 'package:cloud_firestore/cloud_firestore.dart';

// // Define seven different queries with different 'where' conditions
// final query1 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field1', isEqualTo: 'value1');

// final query2 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field2', isLessThan: 10);

// final query3 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field3', isGreaterThanOrEqualTo: DateTime.now());

// final query4 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field4', arrayContains: 'value2');

// final query5 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field5', isNull: true);

// final query6 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field6', whereIn: ['value3', 'value4']);

// final query7 = FirebaseFirestore.instance
//     .collection('collection_name')
//     .where('field7', isNotEqualTo: 'value5');

// // Fetch data for each query and store them in separate snapshots
// final snapshot1 = await query1.get();
// final snapshot2 = await query2.get();
// final snapshot3 = await query3.get();
// final snapshot4 = await query4.get();
// final snapshot5 = await query5.get();
// final snapshot6 = await query6.get();
// final snapshot7 = await query7.get();

// // Find the common data from all the snapshots
// final commonData = snapshot1.docs.toSet()
//     .intersection(snapshot2.docs.toSet())
//     .intersection(snapshot3.docs.toSet())
//     .intersection(snapshot4.docs.toSet())
//     .intersection(snapshot5.docs.toSet())
//     .intersection(snapshot6.docs.toSet())
//     .intersection(snapshot7.docs.toSet());

// // Store the common data in another new snapshot
// final commonSnapshot = QuerySnapshot.fromQuery(
//   FirebaseFirestore.instance
//       .collection('collection_name')
//       .where(FieldPath.documentId, whereIn: commonData.map((doc) => doc.id).toList()),
// );

// // Access the common data from the commonSnapshot
// final List<DocumentSnapshot> commonDocs = commonSnapshot.docs;