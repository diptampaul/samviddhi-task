import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/assets/backend-api.dart' as backend;
import 'package:frontend/main/show_message.dart';
import 'package:frontend/main/global.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _token = "";
  TextEditingController _id = TextEditingController();
  TextEditingController _native_english_speaker = TextEditingController();
  TextEditingController _course_instructor = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _summer_or_regular = TextEditingController();
  TextEditingController _class_size = TextEditingController();
  TextEditingController _class_attribute = TextEditingController();

  Future<void> addTA() async{
    var headers = {
      'Authorization': "Bearer ${_token}",
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(backend.ADD_TA));

    request.body = json.encode({
    "native_english_speaker": _native_english_speaker.text,
    "course_instructor": _course_instructor.text,
    "course": _course.text,
    "semester": _summer_or_regular.text,
    "class_size": _class_size.text,
    "performance_score": _class_attribute.text
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
          SnackBar snackBar = showMessage("〠 Success !!", "TA Added Successfully", Colors.greenAccent, 2);
          snackbarKey.currentState?.showSnackBar(snackBar);
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

  Future<void> updateTA() async{
    var headers = {
    'Authorization': "Bearer ${_token}",
    'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(backend.UPDATE_TA));

    request.body = json.encode({
      "id": _id.text,
    "native_english_speaker": _native_english_speaker.text,
    "course_instructor": _course_instructor.text,
    "course": _course.text,
    "semester": _summer_or_regular.text,
    "class_size": _class_size.text,
    "performance_score": _class_attribute.text
    });
    request.headers.addAll(headers);
    try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
    Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
    SnackBar snackBar = showMessage("〠 Success !!", "TA updated Successfully", Colors.greenAccent, 2);
    snackbarKey.currentState?.showSnackBar(snackBar);
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


  Future<void> getToken() async{

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(backend.LOGIN));

    request.body = json.encode({
      "username": "admin",
      "password": "password"
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
        print(data);
        _token = data["access_token"];
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
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800]?.withOpacity(0.9),
          centerTitle: true,
          title: const Text("Teaching Assistant", style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold, letterSpacing: 1.2),),
        ),
        body: Column(
          children: [
            Container(
                height: 90.0,
                // color: Colors.red[400],
                padding: const EdgeInsets.fromLTRB(2.5, 15.0, 0, 10.0),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage: AssetImage('assets/images/profile/profile.jpeg'),
                    ),
                  ],
                )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 5.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Id"),
                                    prefixIcon: Icon(Icons.mail_rounded),
                                  ),
                                  controller: _id,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Native English Speaker"),
                                    prefixIcon: Icon(Icons.rotate_left),
                                  ),
                                  controller: _native_english_speaker,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Course Instructor"),
                                    prefixIcon: Icon(Icons.food_bank),
                                  ),
                                  controller: _course_instructor,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Course"),
                                    prefixIcon: Icon(Icons.add_road),
                                  ),
                                  controller: _course,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Semester"),
                                    prefixIcon: Icon(Icons.account_tree_rounded),
                                  ),
                                  controller: _summer_or_regular,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Class Size"),
                                    prefixIcon: Icon(Icons.account_tree_rounded),
                                  ),
                                  controller: _class_size,
                                ),
                                const SizedBox(height: 20.0,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Class Attribute"),
                                    prefixIcon: Icon(Icons.account_tree_rounded),
                                  ),
                                  controller: _class_attribute,
                                ),
                                const SizedBox(height: 20.0,),
                                SizedBox(
                                  width: 200.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      addTA();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[500],
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()
                                    ),
                                    child: const Text("Add TA", style: TextStyle(color: Colors.white70),),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                SizedBox(
                                  width: 200.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      updateTA();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[500],
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()
                                    ),
                                    child: const Text("Update TA", style: TextStyle(color: Colors.white70),),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
