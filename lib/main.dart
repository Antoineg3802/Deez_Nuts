import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(
        title: 'DeezNuts',
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _indexOfMusic = 0;
  double duration = 0;

  List<Music> myMusicList = [
    Music('RAF', 'PLK', 'https://raplume.eu/wp-content/uploads/2021/11/ENNA-BOOST.jpg', 'https://www.mboxdrive.com/raf.mp3'),
    Music('Arretez', 'Mastu/Theodort', 'https://yt3.ggpht.com/ytc/AKedOLQx97aq_scXX6iur9THIHnR5IC5a3kdy2WZa2ck2w=s400-c-k-c0x00ffffff-no-rj', 'https://www.mboxdrive.com/mastu-theodort-arretez-remix.mp3'),
    Music('Deux frères', 'PNL', 'https://i.discogs.com/F-XeA1ydskLfzwMDNFPN32DGm5EnVT8pAb-JUNtmQbU/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTE0NDg2/NDg4LTE1NzU5MDgw/NjktOTg0NC5qcGVn.jpeg', 'https://www.mboxdrive.com/pnl-deux-freres-clip-officiel.mp3'),
  ];

  String playPause = 'https://cdn-icons-png.flaticon.com/512/27/27223.png';

  var player = AudioPlayer();

  void previous(){
    setState(() {
      if (_indexOfMusic == 0){
        _indexOfMusic = myMusicList.length - 1;
      }else {
        _indexOfMusic--;
      }
      updateSong();
    });
  }

  void play(){
    setState(() {
      updateSong();
      if (playPause == 'https://cdn-icons-png.flaticon.com/512/27/27223.png'){
        playPause = 'https://cdn-icons-png.flaticon.com/512/1214/1214679.png';
        player.play();
      }else{
        player.pause(); 
        playPause = 'https://cdn-icons-png.flaticon.com/512/27/27223.png';
      }
    });
  }

  void next(){
    setState(() {
      if (_indexOfMusic == myMusicList.length - 1){
        _indexOfMusic = 0;
      }else {
        _indexOfMusic++;
      }
      updateSong();
    });
  }

  void updateSong(){
    if (player.playing){
      player.pause();
      playPause = 'https://cdn-icons-png.flaticon.com/512/1214/1214679.png';
    }
    player.setUrl(myMusicList[_indexOfMusic].urlSong);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: mounted,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image(
                image: NetworkImage(
                  myMusicList[_indexOfMusic].imagePath,
                ),
                fit: BoxFit.fill,
              ),
            ),
            Text(
              myMusicList[_indexOfMusic].singer,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              myMusicList[_indexOfMusic].title,
              style: TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: previous,
                  child: const Image(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/2/2147.png'),
                    height: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: play,
                    child: Image(
                      image: NetworkImage(
                        playPause,
                      ),
                      height: 50,
                    ),
                  ),
                ),
                InkWell(
                  onTap: next,
                  child: const Image(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/1/1371.png'),
                    height: 50,
                  ),
                ),
              ],
            )
          ]
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
