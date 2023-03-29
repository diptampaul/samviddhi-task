import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/assets/backend-api.dart' as backend;
import 'package:frontend/main/show_message.dart';
import 'package:frontend/main/global.dart';


class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String _token = "";
  TextEditingController _id = TextEditingController();

  Future<void> deleteTA() async{
    var headers = {
    'Authorization': "Bearer ${_token}",
    'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(backend.DELETE_TA));

    request.body = json.encode({
      "id": _id.text
    });
    request.headers.addAll(headers);
    try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
    Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
    SnackBar snackBar = showMessage("〠 Success !!", "TA deleted Successfully", Colors.greenAccent, 2);
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
      if (response.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(await response.stream.bytesToString());
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
                                SizedBox(
                                  width: 200.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/retrieve-data", arguments: _id.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[500],
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()
                                    ),
                                    child: const Text("SEE TA", style: TextStyle(color: Colors.white70),),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                SizedBox(
                                  width: 200.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      deleteTA();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[500],
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()
                                    ),
                                    child: const Text("DELETE TA", style: TextStyle(color: Colors.white70),),
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
