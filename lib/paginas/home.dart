import 'package:flutter/material.dart';
import 'package:notificaciones/notificaciones/gestor_notificaciones.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PantallaNotificaciones();
  }
}

class PantallaNotificaciones extends StatefulWidget {
  @override
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<PantallaNotificaciones> {
  GestorNotificaciones _gestorNotificaciones = GestorNotificaciones();

  Map<String, bool> valores = {
    "Tema1": false,
    "Tema2": false,
    "Tema3": false,
    "Tema4": false,
    "Tema5": false,
    "Tema6": false,
    "Tema7": false,
    "Tema8": false,
  };

  void registrarTemas() {
    List<String> temas = List<String>();

    valores.forEach((key, value) {
      if (value) {
        temas.add(key);
      }
    });

    _gestorNotificaciones.registrarTemas(temas);
  }

  void olvidarTemas() {
    List<String> temas = List<String>();

    valores.forEach((key, value) {
      if (value) {
        temas.add(key);
      }
    });

    _gestorNotificaciones.olvidarTemas(temas);
  }

  //Debería limpiar los checkbox, aún no funciona
  void borrarSeleccion() {
    valores.values.forEach((element) => element = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mensaje"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: valores.keys.map((clave) {
                    return CheckboxListTile(
                      title: Text(clave),
                      value: valores[clave],
                      onChanged: (bool valor) {
                        setState(() {
                          valores[clave] = valor;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Center(
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Registrar temas"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          registrarTemas();
                          borrarSeleccion();
                        },
                      ),
                      FlatButton(
                        child: Text("Olvidar temas"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          olvidarTemas();
                          borrarSeleccion();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
