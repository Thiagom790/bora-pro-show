import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/repositories/post.repository.dart';

class PostController {
  late PostRepository _repositoryPost;

  PostController() {
    _repositoryPost = PostRepository();
  }

  Future<List<PostModel>> selectAllPosts() async {
    try {
      return await _repositoryPost.selectAllPosts();
    } catch (e) {
      throw e;
    }
  }

  Future<String> followMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      return await _repositoryPost.followMusician(
          userID: userID, musicianID: musicianID);
    } catch (e) {
      throw e;
    }
  }

  Future<void> unFollowMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      return await _repositoryPost.unFollowMusician(
        userID: userID,
        musicianID: musicianID,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<bool> userFollowMusician({
    required String userID,
    required String musicianID,
  }) async {
    try {
      return await _repositoryPost.userFollowMusician(
        userID: userID,
        musicianID: musicianID,
      );
    } catch (e) {
      throw e;
    }
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

  Future<void> updatePost(PostModel post) async {
    try {
      await _repositoryPost.updatePost(post);
    } catch (e) {
      throw e;
    }
  }
}
