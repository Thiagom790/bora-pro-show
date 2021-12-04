import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/post.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/text.button.widget.dart';

class Createpostview extends StatefulWidget {
  const Createpostview({Key? key}) : super(key: key);

  @override
  _CreatepostviewState createState() => _CreatepostviewState();
}

class _CreatepostviewState extends State<Createpostview> {
  late ProfileStore _store;
  final _textController = TextEditingController();
  final _postController = PostController();
  bool _isLoading = false;
  bool _isError = false;
  String _msg = "";

  Future<void> _createPost() async {
    final text = _textController.text;
    final musicianName = _store.name;
    final musicianID = _store.id;
    final date = DateTime.now();
    final post = new PostModel(
      text: text,
      musicianName: musicianName,
      id: musicianID,
      dateTime: date,
    );

    try {
      await _postController.addPost(post);
    } catch (e) {
      throw e;
    }
  }

  void _handleCreatePost() {
    this._createPost().then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        this._isLoading = false;
        this._isError = true;
        this._msg = error.toString();
      });
    });

    setState(() {
      this._isLoading = true;
    });
  }

  Widget get body {
    if (this._isLoading) {
      return LoadingWidget();
    } else if (_isError) {
      return ErrorCustomWidget(errorTitle: this._msg);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.container,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/tiaguinho.jpg"),
                ),
              ),
              Text(
                "Thiago Marques",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: this._handleCreatePost,
                child: Text(
                  "Publicar",
                  style: TextStyle(
                    color: AppColors.textLight,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.buttonPrimary,
                ),
              ),
            ],
          ),
          InputWidget(
            padding: EdgeInsets.symmetric(vertical: 10),
            maxLines: 19,
            placeholder: "No que está pensando?",
            controller: _textController,
          ),
          Container(
            child: Row(
              children: <Widget>[
                TextButtonWidget(
                  title: "Imagem",
                  icon: Icons.image,
                  onPress: () {},
                ),
                TextButtonWidget(
                  title: "Video",
                  icon: Icons.video_call,
                  onPress: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Post"),
      ),
      body: body,
    );
  }
}
