import 'package:flutter/material.dart';


const String _name = "Vartul";

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  State createState() => new ChatScreenState();
}


class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  //new
  @override                                                        //new
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("ChatBox")),
      body: new Column(                                        //modified
        children: <Widget>[                                         //new
          new Flexible(                                             //new
            child: new ListView.builder(                            //new
              padding: new EdgeInsets.all(8.0),                     //new
              reverse: true,                                        //new
              itemBuilder: (_, int index) => _messages[index],      //new
              itemCount: _messages.length,                          //new
            ),                                                      //new
          ),                                                        //new
          new Divider(height: 1.0),                                 //new
          new Container(                                            //new
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),                                                        //new
        ],                                                          //new
      ),                                                            //new
    );
  }



  Widget _buildTextComposer() {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(                                            //new
        children: <Widget>[                                      //new
      new Flexible(
      child: new TextField(
        controller: _textController,
        onSubmitted: _handleSubmitted,
        decoration: new InputDecoration.collapsed(
            hintText: "Send a message"),
      ),
    ),
      new Container(                                                 //new
        margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
        child: new IconButton(                                       //new
            icon: new Icon(Icons.send),                                //new
            onPressed: () => _handleSubmitted(_textController.text)),  //new
      ),
    ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(                  //new
        duration: new Duration(milliseconds: 700),                   //new
        vsync: this,                                                 //new
      ),                                                             //new
    );                                                               //new
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();                           //new
  }



}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final AnimationController animationController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}