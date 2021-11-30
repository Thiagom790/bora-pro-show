import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';

class createpostview extends StatefulWidget {
  const createpostview({Key? key}) : super(key: key);

  @override
  _createpostviewState createState() => _createpostviewState();
}

class _createpostviewState extends State<createpostview> {
  final postController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Post"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InputWidget(
                  onTap: () {},
                  maxLines: 30,
                  placeholder: "No que está pensando?",
                  readOnly: false,
                  controller: postController,
                ),
              ]),
        ),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: AppColors.background,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.image), label: 'Adicionar Imagem'),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_video_outlined),
                label: 'Adicionar Vídeo'),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
