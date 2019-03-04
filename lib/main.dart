import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';                      //new


void main() => runApp(new FriendlychapApp());

class FriendlychapApp extends StatelessWidget {
  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendlychat',
      theme: defaultTargetPlatform == TargetPlatform.iOS
      ? kIOSTheme : kDefaultTheme,
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

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendlychat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index],
                    itemCount: _messages.length)
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),

          ],

        ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS //new
              ? new BoxDecoration(                                     //new
            border: new Border(                                  //new
              top: new BorderSide(color: Colors.grey[200]),      //new
            ),                                                   //new
          )                                                      //new
              : null),
      );

  }

  void _handlerSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    ChatMessage message = new ChatMessage(text: text,
        animationController: new AnimationController(                  //new
          duration: new Duration(milliseconds: 700),                   //new
          vsync: this,
        )
    );
    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onChanged: (String text){
              setState(() {
                _isComposing = text.length > 0;
              });
            },
            onSubmitted: _handlerSubmitted,
            decoration: InputDecoration.collapsed(hintText: 'Send a message'),
          )
          ),
          Container(
          margin: new EdgeInsets.symmetric(horizontal: 4.0),
          child: Theme.of(context).platform == TargetPlatform.iOS ?  //modified
           CupertinoButton(                                       //new
          child: new Text("Send"),                                 //new
          onPressed: _isComposing                                  //new
          ? () =>   _handlerSubmitted(_textController.text)  //new
              : null,) :
           IconButton(
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

class ChatMessage extends StatelessWidget {
   String _name = "Your Name";
   final AnimationController animationController;
  ChatMessage({this.text , this.animationController });
  final String text;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut),
      axisAlignment: 8.0,
      child:  Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],

              ),

            ),
          ],
        ),
      ),
    );





  }
}
