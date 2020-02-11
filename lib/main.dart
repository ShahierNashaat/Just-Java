import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  String _name = '';
  bool _whippedcream = false;
  bool _chocolate = false;
  int _quantity = 2;
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  void _decreass(){
    if(_quantity != 1){
      setState(() {
        _quantity--;
      });
    }
    else{
      _scaffoldState.currentState.showSnackBar(SnackBar(
        content: Text('You cannot have less than 1 coffees'),
      ));
    }
  }

  void _increass(){
    if(_quantity != 100){
      setState(() {
        _quantity++;
      });
    }
    else{
      _scaffoldState.currentState.showSnackBar(SnackBar(
        content: Text('You cannot have more than 100 coffees'),
      ));
    }
  }

  void _order() async{
    int cup_price = 5;
    if(_whippedcream){
      cup_price++;
    }
    if(_chocolate){
      cup_price += 2;
    }
    int total = cup_price*_quantity;

    String body = 'Name: ${_name}\nAdd whipped cream? ${_whippedcream.toString()}\n'
        'Add chocolate? ${_chocolate.toString()}\nQuantity: ${_quantity.toString()}\nTotal: \$${total.toString()}\nThank you!';
    print(body);

    final Email email = Email(
      body : body,
      subject: 'Just Java order for ${_name}'
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Just Java'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                focusColor: Colors.blue,
              ),
              onChanged: (String name){
                setState(() {
                  _name = name;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TOPPINGS',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  onChanged: (bool whippedcream){
                    setState(() {
                      _whippedcream = whippedcream;
                    });
                  },
                  value: _whippedcream,
                ),
                Text('Whipped cream'),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  onChanged: (bool chocolate){
                    setState(() {
                      _chocolate = chocolate;
                    });
                  },
                  value: _chocolate,
                ),
                Text('Chocolate'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'QUANTITY',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                  child: RaisedButton(onPressed: _decreass, child: Text('-'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(_quantity.toString()),
                ),
                SizedBox(
                  width: 50.0,
                  child: RaisedButton(onPressed: _increass, child: Text('+'),),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  onPressed: _order,
                  child: Text('ORDER'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}