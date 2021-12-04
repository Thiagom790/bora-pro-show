import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/repositories/post.repository.dart';

class PostController {
  late PostRepository _repositoryPost;

  PostController() {
    _repositoryPost = PostRepository();
  }

  Future<String> addPost(PostModel post) async {
    try {
      return await this._repositoryPost.addPost(post);
    } catch (e) {
      throw e;
    }
  }
}
