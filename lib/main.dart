import 'package:flutter/material.dart';

void main() => runApp(new FriendlychapApp());

class FriendlychapApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendlychat',
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendlychat'),
      ),
      body: _buildTextComposer(),
    );
  }

  void _handlerSubmitted(String text) {
    _textController.clear();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handlerSubmitted,
            decoration: InputDecoration.collapsed(hintText: 'Send a message'),
          )
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.blueAccent,
                onPressed: () => _handlerSubmitted(_textController.text)),
          )
        ],
      ),
      /*    child: ,*/
    );
  }
}
