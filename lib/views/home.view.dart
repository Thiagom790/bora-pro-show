import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/post.controller.dart';
import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/views/musician.search.view.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _postController = PostController();

  void _openSearchProfileMusician() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicianSearchView()),
    );
  }

  Future<List<PostModel>> selectAllPosts() async {
    try {
      return await _postController.selectAllPosts();
    } catch (e) {
      throw e;
    }
  }

  Future<void> handleLike(PostModel post) async {
    try {
      post.numLikes = post.numLikes + 1;
      await _postController.updatePost(post);
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: selectAllPosts(),
      builder: (context, snapshot) {
        if (ConnectionState.none == snapshot.connectionState ||
            ConnectionState.waiting == snapshot.connectionState) {
          return LoadingWidget();
        }
        if (ConnectionState.done == snapshot.connectionState &&
            snapshot.hasError) {
          String error = snapshot.error.toString();
          return ErrorCustomWidget(errorTitle: error);
        }

        var list = snapshot.data!;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              MusicianSearchBar(
                readOnly: true,
                onPressed: _openSearchProfileMusician,
              ),
              ...list.map((post) {
                return Postwidget(
                  postModel: post,
                  likeOnTap: () => handleLike(post),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
