import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Se recibe el argumento de main con la información de la notificación (si se requiere manejarla):
    final info = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mensaje"),
      ),
      body: Center(
        child: Text(info),
      ),
    );
  }
}
