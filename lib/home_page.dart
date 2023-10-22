import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proyecto_grafos/algorithms/arboles/arboles_binarios.dart';
import 'package:proyecto_grafos/algorithms/jhonson/home_jhonson.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/ordenamiento_manual_view.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/ordenamiento_view.dart';
import 'package:proyecto_grafos/home.dart';
import 'algorithms/asignación/home_asignacion.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> graphImages = [
    {
      'imagePath': 'assets/img01.jpeg',
      'quote': 'Los grafos y nodos revelan la estructura oculta del mundo.',
    },
    {
      'imagePath': 'assets/img02.jpeg',
      'quote': 'Cada grafo es un camino hacia el entendimiento.',
    },
    {
      'imagePath': 'assets/img03.jpeg',
      'quote': 'Los nodos son los puntos de encuentro de las ideas.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Análisis de Algoritmos'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio:
                      MediaQuery.of(context).size.width > 600 ? 16 / 5 : 4 / 5,
                  viewportFraction: 0.3, // Cambiar el tamaño del carrusel
                  enlargeCenterPage: true,
                ),
                items: graphImages.map((imageInfo) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.height * 0.4
                            : MediaQuery.of(context).size.height * 0.4,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                imageInfo['imagePath']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '"${imageInfo['quote']}"',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      fontSize: 20,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text('Ir al Graficador de Grafos'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple.shade600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Agregar espacio entre botones
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeJhonson()));
                    },
                    child: Text('Johnson'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple.shade600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Agregar espacio entre botones
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeAsignacion()));
                    },
                    child: Text('Asignación'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple.shade600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Agregar espacio entre botones
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black, // Fondo negro
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Espaciado interno
                            title: Text(
                              'Algoritmos de Ordenamiento',
                              style: TextStyle(
                                color: Colors.white, // Título en blanco
                                fontSize: 20, // Tamaño de fuente
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize
                                  .min, // Ajusta el tamaño del contenido
                              children: [
                                Text(
                                  'Seleccione una opción para ver el algoritmo de ordenamiento',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white, // Texto en blanco
                                  ),
                                ),
                                SizedBox(height: 20), // Espacio vertical
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdenamientoView(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors
                                            .green), // Cambia el color del botón
                                  ),
                                  child: Text(
                                    'Números Aleatorios',
                                    style: TextStyle(
                                      color: Colors.white, // Texto en blanco
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10), // Espacio adicional
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdenamientoView(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors
                                            .blue), // Cambia el color del botón
                                  ),
                                  child: Text(
                                    'Ingresar Números Manualmente',
                                    style: TextStyle(
                                      color: Colors.white, // Texto en blanco
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black, // Fondo negro
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1), // Borde blanco delgado
                              borderRadius: BorderRadius.circular(
                                  10), // Bordes redondeados
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Algoritmos de Ordenamiento',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Seleccione una opción para ver el algoritmo de ordenamiento',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdenamientoView(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors
                                            .teal), // Cambia el color del botón
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Bordes redondeados
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(
                                        4), // Elevación del botón
                                  ),
                                  child: AnimatedBuilder(
                                    animation:
                                        _animationController, // Animación de crecimiento y reducción
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: 1 +
                                            _animationController.value *
                                                0.05, // Escala con animación
                                        child: child,
                                      );
                                    },
                                    child: Text(
                                      'Números Aleatorios',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdenamientoManualView(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors
                                            .indigo), // Cambia el color del botón
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Bordes redondeados
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(
                                        4), // Elevación del botón
                                  ),
                                  child: AnimatedBuilder(
                                    animation:
                                        _animationController, // Animación de crecimiento y reducción
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: 1 +
                                            _animationController.value *
                                                0.05, // Escala con animación
                                        child: child,
                                      );
                                    },
                                    child: Text(
                                      'Ingresar Números Manualmente',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Algoritmos de Ordenamiento'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple.shade600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArbolesBinariosScreen()));
                    },
                    child: Text('Árboles'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 57, 144, 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      '¡Explora el Fascinante Mundo de los Grafos!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Updated text content and styling
                    Text(
                      '🌐🔍 Los grafos son como mapas que desvelan conexiones entre elementos. Cada nodo y arista cuenta una historia única. Descubre cómo los nodos, conectados por aristas, forman un rompecabezas interconectado. 🧩✨',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Updated text content and styling
                    Text(
                      '🔮🔗 La matriz de adyacencia es tu clave para decodificar estas conexiones. Con "1s" y "0s", revela qué nodos están unidos y cuáles están separados. ¡Desentraña el patrón y descubre la estructura oculta! 🕵‍♀🌌',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Desarrolladores',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 20),
                    // Updated Card layout and styling
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.code,
                              size: 50,
                              color: Colors.purple,
                            ),
                            SizedBox(height: 20),
                            // Improved developer names presentation
                            Text(
                              '@Campero__jose\n@MoronDiego\n@Ismaelolazo\n@Ruddy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Implement the action for the "Ir al proyecto en GitHub" button
                              },
                              child: Text('Ir al proyecto en GitHub'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purple.shade600,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
