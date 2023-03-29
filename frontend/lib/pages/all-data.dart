import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/assets/backend-api.dart' as backend;
import 'package:frontend/main/show_message.dart';
import 'package:frontend/main/global.dart';


class AllDataScreen extends StatefulWidget {
  const AllDataScreen({Key? key}) : super(key: key);

  @override
  State<AllDataScreen> createState() => _AllDataScreenState();
}

class _AllDataScreenState extends State<AllDataScreen> {
  List<Map<String, dynamic>> myList = [];


  Future<void> getData() async{

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(backend.RETRIEVE_ALL));

    request.body = json.encode({
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
        for(int i = 0; i < data["data"].length; i++){
          Map<String, dynamic> eachUser = {
            'native_english_speaker': data["data"][i]["native_english_speaker"].toString(),
            'course_instructor': data["data"][i]["course_instructor"].toString(),
            'course': data["data"][i]["course"].toString(),
            'summer_or_regular': data["data"][i]["summer_or_regular"].toString(),
            'class_size': data["data"][i]["class_size"].toString(),
            'class_attribute': data["data"][i]["class_attribute"].toString(),
          };
          myList.add(eachUser);
        }
      }else {
        SnackBar snackBar = showMessage("Sorry !!", "Something bad happened at our side", Colors.redAccent, 2);
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    }on Exception catch (exception) {
      SnackBar snackBar = showMessage("Sorry !!", "Something exception happened at our side \n$exception", Colors.redAccent, 2);
      snackbarKey.currentState?.showSnackBar(snackBar);
    } catch (error) {
      SnackBar snackBar = showMessage("Sorry !!", "Something error happened at our side \n$error", Colors.redAccent, 2);
      snackbarKey.currentState?.showSnackBar(snackBar);
    }

    setState(() {
      print("DOne");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800]?.withOpacity(0.9),
        centerTitle: true,
        title: const Text("All Teaching Assistant", style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold, letterSpacing: 1.2),),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: myList.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('native_english_speaker: ${myList[index]['native_english_speaker']}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text('course_instructor: ${myList[index]['course_instructor']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text('course: ${myList[index]['course']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text('summer_or_regular: ${myList[index]['summer_or_regular']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text('class_size: ${myList[index]['class_size']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text('class_attribute: ${myList[index]['class_attribute']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 3),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
