
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';

class ImageService {
  final Reference _firestorage = FirebaseStorage.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImage(String path, Uint8List bytes) async {

    
    final uid = auth.currentUser!.uid;
    final firebaseStorageLocation = _firestorage.child(uid).child('images');
    final fireBaseFileLocation = firebaseStorageLocation.child(path);

    print(bytes);

    try {
      // Upload raw data.
      await fireBaseFileLocation.putData(bytes);
      return fireBaseFileLocation.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
    }catch(e)
    {
      print('error logic'+e.toString());
    }
    return '';
  }

  Future<String> downloadImage(String path) async {

    final uid = auth.currentUser!.uid;
    final firebaseStorageLocation = _firestorage.child(uid).child('images');
    final imageRef = firebaseStorageLocation.child(path);
    return imageRef.getDownloadURL();


//   final file = File('images/$path');

// final downloadTask = islandRef.writeToFile(file);
// downloadTask.snapshotEvents.listen((taskSnapshot) {
//   switch (taskSnapshot.state) {
//     case TaskState.running:
//       // TODO: Handle this case.
//       break;
//     case TaskState.paused:
//       // TODO: Handle this case.
//       break;
//     case TaskState.success:
//       // TODO: Handle this case.
//       break;
//     case TaskState.canceled:
//       // TODO: Handle this case.
//       break;
//     case TaskState.error:
//       // TODO: Handle this case.
//       break;
//   }});
    
  }
}

final imageService = Provider((ref) => ImageService());
