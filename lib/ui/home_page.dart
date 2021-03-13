import 'package:flutter/material.dart';
import 'package:socket/core/local_notification.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  IOWebSocketChannel channel;
  TextEditingController controller;
  @override
  void initState() {
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    controller = TextEditingController();
    // IOWebSocketChannel.connect('ws://echo.websocket.org')
    //     .stream
    //     .listen((event) {
    //   print('mDebug: init stream $event');
    // });

    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                channel.sink.add(controller.text);
              },
              child: Text('send'),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active)
                  LocalNotification().showNofication(
                      title: 'text entered', body: snapshot.data.toString());
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
