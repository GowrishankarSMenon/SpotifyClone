import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

class UploaderAndFixer {
  final storageRef = FirebaseStorage.instance.ref().child('songs/');
  final firestoreRef = FirebaseFirestore.instance.collection('songs');

  // Method to handle both fixing and uploading
  Future<void> fixAndUpload() async {
    await _fixExistingDurations();
    await _uploadNewSongs();
  }

  // Fix durations for existing Firestore entries
  Future<void> _fixExistingDurations() async {
    final querySnapshot = await firestoreRef.get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final String storagePath = data['storagePath'];
      final String currentDuration = data['duration'] ?? 'Unknown Duration';

      // Skip entries with the correct duration format or that already have a readable format
      if (currentDuration != 'Unknown Duration' && currentDuration.contains(':')) {
        continue;
      }

      // Calculate the correct duration
      final formattedDuration = await _getFormattedDuration(storagePath);

      // Update Firestore document
      await firestoreRef.doc(doc.id).update({
        'duration': formattedDuration,
      });

      print('Updated duration for ${data['title']}: $formattedDuration');
    }

    print('Duration fixing complete.');
  }

  // Upload new songs with metadata
  Future<void> _uploadNewSongs() async {
    final ListResult result = await storageRef.listAll();
    final List<Reference> allFiles = result.items;

    for (Reference fileRef in allFiles) {
      final String fileURL = await fileRef.getDownloadURL();
      
      // Check for duplicates before proceeding
      final bool exists = await _checkIfSongExists(fileURL);
      if (exists) {
        print('Song already exists in Firestore: $fileURL');
        continue;
      }

      final FullMetadata metadata = await fileRef.getMetadata();

      // Extracting song title and artist(s) from file name
      final String fileName = fileRef.name.replaceAll('.m4a', '');
      final List<String> fileNameParts = fileName.split(' - ');

      // Assuming format is "Title - Artist1, Artist2.m4a"
      final String songTitle = fileNameParts.length > 1 ? fileNameParts[0] : fileName;
      final String artistName = fileNameParts.length > 1 ? fileNameParts[1] : 'Unknown Artist';

      // Calculate the duration
      final formattedDuration = await _getFormattedDuration(fileURL);

      // Constructing the song data
      final songData = {
        'title': songTitle,
        'artist': artistName,  // Include all artists as a single string
        'storagePath': fileURL,
        'coverUrl': 'url_to_cover_image',  // Update this if you have a cover image
        'duration': formattedDuration,
      };

      // Uploading the metadata to Firestore
      await firestoreRef.add(songData);
      print('Uploaded song: $songTitle');
    }

    print('New songs upload complete.');
  }

  // Helper method to check for duplicates
  Future<bool> _checkIfSongExists(String fileURL) async {
    final querySnapshot = await firestoreRef.where('storagePath', isEqualTo: fileURL).get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Helper method to calculate and format duration
  Future<String> _getFormattedDuration(String url) async {
    final player = AudioPlayer();
    try {
      await player.setSourceUrl(url);
      final duration = await player.getDuration();
      if (duration != null) {
        final minutes = duration.inMinutes;
        final seconds = duration.inSeconds % 60;
        return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      } else {
        return 'Unknown Duration';
      }
    } catch (e) {
      print('Error getting duration for $url: $e');
      return 'Unknown Duration';
    }
  }
}
