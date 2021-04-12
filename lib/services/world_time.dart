import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an assert flag icon
  String url; // location url for api endpoint
  bool isDayTime; //t or f if daytime

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{
      //Asia/Kolkata
      var URL = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      http.Response response =await http.get(URL);
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      //Set the time property
      //time = now.toString();

      isDayTime = (now.hour > 6 && now.hour < 15)? true : false ;

      //Set the time property using intl
      time = DateFormat.jm().format(now);

      // Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
      //jsonDecode(response.body);
      //print(response);
      //simulate network request
      // String username = await Future.delayed(Duration(seconds: 3), (){
      //   return 'Groot';
      // });
      //
      // String bio = await Future.delayed(Duration(seconds: 2), (){
      //   return 'lol lol lol';
      // });
      // print('$username and $bio');


    } catch(e){
      print('caught error: $e');
      time = 'could not get time';
    }


      }
}

