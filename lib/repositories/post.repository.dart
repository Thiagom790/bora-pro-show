import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/post.model.dart';

class PostRepository {
  final _reference = FirebaseFirestore.instance.collection('posts');

  Future<String> addPost(PostModel post) async {
    try {
      final refs = await _reference.add(post.toMap());
      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  PostModel _buildListPost(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final postMap = doc.data();
    postMap['id'] = doc.id;

    return PostModel.fromMap(postMap);
  }

  Future<List<PostModel>> selectPostsMusician(String musicianID) async {
    try {
      final snapshots =
          await _reference.where("musicianID", isEqualTo: musicianID).get();

      final documents = snapshots.docs;

      final list = documents.map(_buildListPost).toList();

      return list;
    } catch (e) {
      throw e;
    }
  }
}
