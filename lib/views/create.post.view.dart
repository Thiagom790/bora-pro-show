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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/tiaguinho.jpg"),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                  ),
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.container,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  "Thiago Marques",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Publicar",
                      style: TextStyle(
                        color: AppColors.textLight,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                    ),
                  ),
                ),
              ],
            ),
            InputWidget(
              onTap: () {},
              maxLines: 19,
              placeholder: "No que está pensando?",
              readOnly: false,
              controller: postController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: AppColors.container,
            primaryColor: Colors.white,
            buttonColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.image), label: 'Adicionar Imagem'),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_video_outlined),
                label: 'Adicionar Vídeo'),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: AppColors.textAccent,

          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
