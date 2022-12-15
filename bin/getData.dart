import 'dart:convert';

import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/database.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'config.dart';

class GetDate {
  Handler get handler {
    Router router = Router();

    router.get('/userDetails', (request) async {
      var app = await initApp();
      final db = FirebaseDatabase(
        app: app,
        databaseURL: FirebaseConfiguration.firebaseConfig[
            'https://test-52243-default-rtdb.asia-southeast1.firebasedatabase.app/user'],
      );

      final ref = db.reference().child('user');

      var resposeData;

      await ref.once().then((value) {
        resposeData = value.value;
      });

      return Response.ok(jsonEncode(resposeData), headers: {});
    });
    return router;
  }

  Future<FirebaseApp> initApp() async {
    late FirebaseApp app;
    try {
      app = Firebase.app();
    } catch (e) {
      app = await Firebase.initializeApp(
          options:
              FirebaseOptions.fromMap(FirebaseConfiguration.firebaseConfig));
    }
    return app;
  }
}
