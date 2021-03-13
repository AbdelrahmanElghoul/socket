
import 'package:web_socket_channel/io.dart';

class Socket{


  init(){
    final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    
  }
}