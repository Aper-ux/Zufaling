import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types
class tutorial extends StatefulWidget {
  const tutorial({super.key});

  static String id = 'tutorial';

  @override
  State<tutorial> createState() => _tutorialState();
}

// ignore: camel_case_types
class _tutorialState extends State<tutorial> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Crea un controlador de video y lo inicializa con el archivo de video
    _controller = VideoPlayerController.asset('assets/prueba.mp4');

    // Inicializa el controlador de video
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Libera los recursos del controlador de video
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('CordinAPP',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const Text('Tutorial',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            Container(
              width: 320,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color.fromARGB(208, 0, 0, 0),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.white),
                  left: BorderSide(width: 1.0, color: Colors.white),
                  right: BorderSide(width: 1.0, color: Colors.white),
                  bottom: BorderSide(width: 1.0, color: Colors.white),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              /* insert a video */
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  // Si el video se está reproduciendo, lo pausa
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // Si el video no se está reproduciendo, lo inicia
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'login');
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    ));
  }
}
