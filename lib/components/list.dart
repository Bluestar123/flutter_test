import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import '../views/detail.dart';

class Listaaa extends StatefulWidget{
  @override
  ListState createState() => new ListState();
}

class ListState extends State<Listaaa>{
  var data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getData();
    return new ListView.builder(
        itemCount:data==null ?0:data.length,
        itemBuilder: (BuildContext context,int index){
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: new ListTile(
                subtitle: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                              data[index]['title'],
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                            ),
                          ),
                            ],
                          ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text('时间：'),
                              new Text('2012-12-12 12:12'),
                            ],
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                            child: new Text('id:'+data[index]['id'].toString()),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: ()=>_onTap(data[index]['id'].toString()),
              ),
            ),
          );
        }
    );
  }

  void _onTap(String id){
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context,_,__){
          return new Detail(id);
        },
        transitionsBuilder: (_,Animation<double> animation,__,Widget child){
            return new FadeTransition(
                opacity: animation,
              child: new SlideTransition(position: new Tween<Offset>(
                begin: const Offset(0.0, 2.0),
                end:Offset.zero
              ).animate(animation),child:child),
            );
         }
    ));
  }

  getData() async{
    var url ='https://jsonplaceholder.typicode.com/posts';
    var httpClient = new HttpClient();

    var result;
    try{
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if(response.statusCode==HttpStatus.OK){
        var json = await response.transform(UTF8.decoder).join();
        result = JSON.decode(json);
      }else {
        result = 'error getting json data  ${response.statusCode}';
      }
    }catch(exception){
      result ='failed getting json data';
    }
    if(!mounted) return;

    setState(() {
      data = result;
    });
  }
}