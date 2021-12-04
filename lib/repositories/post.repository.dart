import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/post.model.dart';

class PostRepository {
  final _reference = FirebaseFirestore.instance.collection('posts');
  final _referenceUserFollow =
      FirebaseFirestore.instance.collection('userFollow');

  Future<String> followMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      final refs = await _referenceUserFollow.add({
        "userID ": userID,
        "musicianID": musicianID,
      });

      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  Future<void> unFollowMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      final snapshot = await _referenceUserFollow
          .where("userID", isEqualTo: userID)
          .where("musicianID", isEqualTo: musicianID)
          .get();

      final doc = snapshot.docs[0];
      final uidFollow = doc.id;

      await _referenceUserFollow.doc(uidFollow).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> userFollowMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      final snapshot = await _referenceUserFollow.get();

      final docs = snapshot.docs;

      int cont = 0;

      for (var doc in docs) {
        var docMap = doc.data();

        if (docMap['userID'] == userID && docMap['musicianID'] == musicianID) {
          cont++;
        }
      }

      return cont > 0;
    } catch (e) {
      throw e;
    }
  }

  Future<String> addPost(PostModel post) async {
    try {
      final refs = await _reference.add(post.toMap());
      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  Future<void> removePost(String postID) async {
    try {
      await _reference.doc(postID).delete();
    } catch (e) {
      throw e;
    }
  }

  PostModel _buildPost(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final postMap = doc.data();
    postMap['id'] = doc.id;

    return PostModel.fromMap(postMap);
  }

  Future<List<PostModel>> selectPostsMusician(String musicianID) async {
    try {
      final snapshots =
          await _reference.where("musicianID", isEqualTo: musicianID).get();

      final documents = snapshots.docs;

      final list = documents.map(_buildPost).toList();

      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PostModel>> selectAllPosts() async {
    try {
      final snapshots = await _reference.get();

      final documents = snapshots.docs;

      final list = documents.map(_buildPost).toList();

      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      await _reference.doc(post.id).set(post.toMap());
    } catch (e) {
      throw e;
    }
  }
}
