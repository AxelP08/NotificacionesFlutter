import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class GestorNotificaciones {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //Escuchar siempre la llegada de notificaciones y avisar a toda la app.
  final StreamController _streamControllerNotificaciones =
      StreamController<String>.broadcast();
  Stream<String> get mensajes => _streamControllerNotificaciones.stream;

  /* Para recibir notificaciones en Android se debe modificar el archivo manifest (líneas 31 a 34).
      Hay que añadir dos archivos al proyecto de Android: Application.java y FirebaseCloudMessagingPluginRegistrant.java
      Y hacer referencia al archivo Application en el manifest (línea 10).
      Agregar las dependencias a pubspec.yaml y a los archivos build.gradle del proyecto Android.
   */

  inicializarNotificaciones() {
    //Se debe solicitar permiso para notificaciones (Sólo para iOS):
    _firebaseMessaging.requestNotificationPermissions();

    //Si usamos token:
    _firebaseMessaging.getToken().then((token) {
      //Mandar el token a la BD para enviar mensajes individuales:
      print(token);
    });

    _firebaseMessaging.configure(
      //onMessage: Recibir notificación con la app en primer plano.
      onMessage: (notificacion) {
        print("========= ON MESSAGE =========");
        print(notificacion);

        String info;

        //Las notificaciones se reciben diferente en android e iOS:
        if (Platform.isAndroid) {
          info = notificacion['data']['argumento'] ?? "nada";
        } else {
          info = notificacion['argumento'] ?? 'nada';
        }

        //Enviar los datos de la notificación para manejarlos en otra parte:
        _streamControllerNotificaciones.sink.add(info);
      },

      //onResume: Recibir notificación con la app en segundo plano.
      onResume: (notificacion) {
        print("========= ON RESUME =========");
        print(notificacion);

        String info;
        if (Platform.isAndroid) {
          info = notificacion['data']['argumento'] ?? "nada";
        } else {
          info = notificacion['argumento'] ?? 'nada';
        }

        //Enviar los datos de la notificación para manejarlos en otra parte:
        _streamControllerNotificaciones.sink.add(info);
      },

      //onLauch: Recibir notificación con la app totalmente cerrada.
      onLaunch: (notificacion) {
        print("========= ON LAUNCH =========");
        print(notificacion);

        String info;
        if (Platform.isAndroid) {
          info = notificacion['data']['argumento'] ?? "nada";
        } else {
          info = notificacion['argumento'] ?? 'nada';
        }

        //Enviar los datos de la notificación para manejarlos en otra parte:
        _streamControllerNotificaciones.sink.add(info);
      },
    );
  }

  void registrarTemas(List<String> temas) {
    temas.forEach((tema) {
      _firebaseMessaging.subscribeToTopic(tema);
    });
  }

  void olvidarTemas(List<String> temas) {
    temas.forEach((tema) {
      _firebaseMessaging.unsubscribeFromTopic(tema);
    });
  }

  //Método requerido para cerrar el stream que está escuchando
  dispose() {
    _streamControllerNotificaciones?.close();
  }
}
