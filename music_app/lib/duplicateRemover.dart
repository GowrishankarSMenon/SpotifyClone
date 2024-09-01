import 'package:cloud_firestore/cloud_firestore.dart';

class DuplicateRemover {
  final firestoreRef = FirebaseFirestore.instance.collection('songs');

  Future<void> removeDuplicates() async {
    final querySnapshot = await firestoreRef.get();
    final Map<String, String> uniquePaths = {}; // Map to keep track of unique storagePaths and document IDs
    final List<String> duplicates = []; // List to store IDs of duplicate documents

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final String storagePath = data['storagePath'];

      if (uniquePaths.containsKey(storagePath)) {
        // Duplicate found, add document ID to duplicates list
        duplicates.add(doc.id);
      } else {
        // Unique document, add storagePath to the map
        uniquePaths[storagePath] = doc.id;
      }
    }

    // Delete duplicate documents
    for (final docId in duplicates) {
      await firestoreRef.doc(docId).delete();
      print('Deleted duplicate document: $docId');
    }

    print('Duplicate removal complete. ${duplicates.length} duplicates deleted.');
  }
}
