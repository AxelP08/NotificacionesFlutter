import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notificaciones/paginas/home.dart';
import 'package:notificaciones/paginas/mensaje.dart';
import 'notificaciones/gestor_notificaciones.dart';

void main() {
  runApp(Inicio());
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final _gestorNotificaciones = GestorNotificaciones();
    _gestorNotificaciones.inicializarNotificaciones();

    //Si se recibe una notificación, ir a la otra pantalla, incluso si la app se abre desde el mensaje:
    _gestorNotificaciones.mensajes.listen((info) {
      //Navigator.pushNamed(context, 'mensaje');
      print("========== DATOS DE LA NOTIFICACIÓN =============");
      print(info);

      //LLamar la otra pantalla y enviar la información de la notificación como argumento:
      navigatorKey.currentState.pushNamed('mensaje', arguments: info);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MensajePage(),
      },
    );
  }
}
