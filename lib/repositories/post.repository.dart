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
}
