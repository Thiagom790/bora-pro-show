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

  Future<void> removePost(String postID) async {
    try {
      return await this._repositoryPost.removePost(postID);
    } catch (e) {
      throw e;
    }
  }

  Future<List<PostModel>> selectPostsMusician(String musicianID) async {
    try {
      return await this._repositoryPost.selectPostsMusician(musicianID);
    } catch (e) {
      throw e;
    }
  }
}
