import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dead Poets App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dead Poets Society'),
      ),
      body: VideoWidget(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'MENÚ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Personajes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vista1()),
                );
              },
            ),
            ListTile(
              title: Text('Momentos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vista2()),
                );
              },
            ),
            ListTile(
              title: Text('Información'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vista3()),
                );
              },
            ),
            ListTile(
              title: Text('Vista 4'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vista4()),
                );
              },
            ),
            ListTile(
              title: Text('Vista 5'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vista5()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/Portada.mp4', // Reemplaza 'your_video.mp4' con la ruta de tu video
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true); // Repetir el video

    _initializeVideoPlayerFuture.then((_) {
      // Inicia la reproducción del video después de la inicialización
      _controller.play();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pausa el video cuando se cambia a una vista diferente o se abre el menú
    _controller.pause();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Vista1 extends StatelessWidget {
  final List<Personaje> personajes = [
    Personaje(
        'Jhon Keating',
        'John Keating es un referente dentro del séptimo arte. Él quería librepensadores en sus clases y no a chavales que se dejaran llevar por las normas y la dura disciplina. Y por supuesto les enseñó uno de los mejores lemas que se pueden aprender en esta vida: "Carpe Diem".',
        'assets/Keating.png'),
    Personaje(
        'Todd Anderson',
        'Anderson es tranquilo y tímido que se deja llevar por sus compañeros para pertenecer al club de los poetas muertos, es una persona que piensa las cosas, pero tiene miedo de decirlas.',
        'assets/Todd.jpg'),
    Personaje(
        'Neil Perry',
        'Neil es un chico obediente, curioso, soñador y con mucho entusiasmo, quien proviene de una familia estable (no rica), debido a el sacrificio de su familia para que el este en la escuela su padre lo presiona para que estudie medicina, pero su mayor sueño es ser actor. ',
        'assets/Neil.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas en la cuadrícula
          crossAxisSpacing: 7.0, // Espacio horizontal entre elementos
          mainAxisSpacing: 7.0, // Espacio vertical entre elementos
        ),
        itemCount: personajes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetallesPersonaje(personaje: personajes[index]),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    personajes[index].foto,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      personajes[index].nombre,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetallesPersonaje extends StatelessWidget {
  final Personaje personaje;

  DetallesPersonaje({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Personaje'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            personaje.foto,
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          Text(
            'Nombre: ${personaje.nombre}',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Descripción: ${personaje.descripcion}',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class Personaje {
  final String nombre;
  final String descripcion;
  final String foto;

  Personaje(this.nombre, this.descripcion, this.foto);
}

class Vista2 extends StatelessWidget {
  final List<MomentoPelicula> momentos = [
    MomentoPelicula('"Nothing"', 'assets/Nothing.jpeg', 'NeilEscene.mp4',
        'Breve valoración del Momento 1'),
    MomentoPelicula('Segundo momento', 'assets/momento2.jpg',
        'VideoMomento2.mp4', 'Breve valoración del Momento 2'),
    MomentoPelicula('Tercer momento', 'assets/momento3.jpg',
        'VideoMomento3.mp4', 'Breve valoración del Momento 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Momentos de la Película'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Cambiado a 1 para mostrar una sola columna
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: momentos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetallesMomento(momento: momentos[index]),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    momentos[index].imagen,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      momentos[index].nombre,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MomentoPelicula {
  final String nombre;
  final String imagen;
  final String video;
  final String valoracion;

  MomentoPelicula(this.nombre, this.imagen, this.video, this.valoracion);
}

class DetallesMomento extends StatelessWidget {
  final MomentoPelicula momento;

  DetallesMomento({required this.momento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Momento'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(
              VideoPlayerController.asset(
                'assets/${momento.video}',
              )..initialize(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            momento.valoracion,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class Vista3 extends StatelessWidget {
  final String anio = '1989'; // Año de la película
  final String director = 'Peter Weir'; // Nombre del director
  final List<String> miembrosReparto = [
    'Robin Williams',
    'Ethan Green Hawke',
    'Robert Lawrence',
    // Puedes agregar más miembros del reparto según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la Película'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Año: $anio',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Director: $director',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Reparto:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            // Lista de miembros del reparto
            for (var miembro in miembrosReparto)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '- $miembro',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Vista4 extends StatefulWidget {
  @override
  _Vista4State createState() => _Vista4State();
}

class _Vista4State extends State<Vista4> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Ruta del video en assets
    _controller = VideoPlayerController.asset('assets/importancia.mp4');

    // Inicializa el controlador
    _initializeVideoPlayerFuture = _controller.initialize();

    // Asegura que el video se reproduzca desde el inicio
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reproducción de Video'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Vista5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información Personal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí puedes agregar la ruta de tu foto en assets o desde una URL
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('assets/IMG_1350.JPG'),
            ),
            SizedBox(height: 20),
            Text(
              'Diego Olivero matos',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Número de Teléfono: +1 849-356-5239',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
