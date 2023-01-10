import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/screens/chat_screen.dart';
import 'package:date_ug/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  CollectionReference chat = FirebaseFirestore.instance.collection("Chats");
  CollectionReference user = FirebaseFirestore.instance.collection("Users");
  String currentUserName = "";
  String friendName = "";
  String currentUserUid = "";
  String friendUid = "";
  String friend = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    dynamic uid = Provider.of<AuthService>(context, listen: false).getUid();
    setState(() {
      currentUserUid = uid;
    });
    await user.where("uid", isEqualTo: uid).get().then((value) {
      dynamic data = value.docs.single.data();
      setState(() {
        currentUserName = data["userName"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(currentUserName);
    // print(currentUserUid);
    return StreamBuilder<QuerySnapshot>(
        stream: chat
            .where("userList", arrayContainsAny: [currentUserUid]).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: CustomAppBar(
                  title: "CHATS", hasActions: true, hasBackButton: true),
              body: Center(
                child: Text(
                  "Something went wrong",
                  style: GoogleFonts.arsenal(),
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              appBar: CustomAppBar(
                  title: "CHATS", hasActions: true, hasBackButton: true),
              body: const Center(
                child: SpinKitWave(
                  color: Colors.black,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(
                    title: "CHATS", hasActions: true, hasBackButton: true),
                body: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // print(snapshot.data!.docs[index]["names"]);
                      // print(snapshot.data!.docs[index]["users"]);

                      // print("currentUserUid :$currentUserUid");
                      if (snapshot.data!.docs[index]["names"]
                              ["currentUserName"] ==
                          currentUserName) {
                        friendName =
                            snapshot.data!.docs[index]["names"]["friendName"];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (snapshot.data!.docs[index]["userList"][0] ==
                                  currentUserUid) {
                                friendUid =
                                    snapshot.data!.docs[index]["userList"][1];
                              } else {
                                friendUid =
                                    snapshot.data!.docs[index]["userList"][0];
                              }
                              if (snapshot.data!.docs[index]["names"]
                                      ["currentUserName"] ==
                                  currentUserName) {
                                friend = snapshot.data!.docs[index]["names"]
                                    ["friendName"];
                              } else {
                                friend = snapshot.data!.docs[index]["names"]
                                    ["currentUserName"];
                              }

                              // print("frienduid :$friendUid");

                              // print("friendName $friend");
                              // print("currentUserName $currentUserName");
                              // print("currentUseruid $currentUserUid");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ChatScreen(
                                      currentUserUid: currentUserUid,
                                      friendName: friend,
                                      friendUid: friendUid,
                                      currentUserName: currentUserName)),
                                ),
                              );
                            },
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 241, 204, 191),
                              title: Text(
                                friendName,
                                style: GoogleFonts.arsenal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        friendName = snapshot.data!.docs[index]["names"]
                            ["currentUserName"];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (snapshot.data!.docs[index]["userList"][0] ==
                                  currentUserUid) {
                                friendUid =
                                    snapshot.data!.docs[index]["userList"][1];
                              } else {
                                friendUid =
                                    snapshot.data!.docs[index]["userList"][0];
                              }
                              if (snapshot.data!.docs[index]["names"]
                                      ["currentUserName"] ==
                                  currentUserName) {
                                friend = snapshot.data!.docs[index]["names"]
                                    ["friendName"];
                              } else {
                                friend = snapshot.data!.docs[index]["names"]
                                    ["currentUserName"];
                              }

                              // print("frienduid :$friendUid");

                              // print("friendName $friend");
                              // print("currentUserName $currentUserName");
                              // print("currentUseruid $currentUserUid");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ChatScreen(
                                      currentUserUid: currentUserUid,
                                      friendName: friend,
                                      friendUid: friendUid,
                                      currentUserName: currentUserName)),
                                ),
                              );
                            },
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 241, 204, 191),
                              title: Text(
                                friendName,
                                style: GoogleFonts.arsenal(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            );
          } else {
            return Scaffold(
              appBar: CustomAppBar(
                  title: "CHATS", hasActions: true, hasBackButton: true),
              body: const Center(
                child: SpinKitWave(
                  color: Colors.black,
                ),
              ),
            );
          }
        });
  }
}
