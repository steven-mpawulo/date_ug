import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserUid;
  final String friendName;
  final String friendUid;
  final String currentUserName;
  const ChatScreen(
      {Key? key,
      required this.currentUserUid,
      required this.friendName,
      required this.friendUid,
      required this.currentUserName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference chat = FirebaseFirestore.instance.collection("Chats");

  String chatId = "";
  TextEditingController messageController = TextEditingController();

  @override
  didChangeDependencies() async {
    await chat
        .where("users",
            isEqualTo: {widget.friendUid: null, widget.currentUserUid: null})
        .limit(1)
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            setState(() {
              chatId = value.docs.single.id;
            });
          } else {
            chat.add({
              "users": {widget.currentUserUid: null, widget.friendUid: null},
              "names": {
                "currentUserName": widget.currentUserName,
                "friendName": widget.friendName,
              },
              "userList": [widget.currentUserUid, widget.friendUid]
            }).then((value) {
              setState(() {
                chatId = value.id;
              });
            });
            super.didChangeDependencies();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    if (chatId.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.friendName,
            style: GoogleFonts.arsenal(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Center(
            child: SpinKitWave(
              color: Colors.black,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 241, 204, 191),
            title: Text(
              widget.friendName,
              style: GoogleFonts.arsenal(),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: StreamBuilder(
              stream: chat.doc(chatId).collection("messages").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Something went wrong",
                      style: GoogleFonts.arsenal(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: chat
                        .doc(chatId)
                        .collection("messages")
                        .orderBy("createdOn", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Something went wrong",
                            style: GoogleFonts.arsenal(),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  bool isSender = false;
                                  if (snapshot.data!.docs[index]["sender"] ==
                                      widget.currentUserUid) {
                                    isSender = true;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChatBubble(
                                      alignment: isSender
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      backGroundColor: isSender
                                          ? const Color(0xff9FDFDC)
                                          : const Color(0xffa7e2ad),
                                      clipper: ChatBubbleClipper2(
                                          type: isSender
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble),
                                      child: Text(
                                        snapshot.data!.docs[index]["msg"],
                                        style: GoogleFonts.arsenal(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 80.0,
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: messageController,
                                        style: GoogleFonts.arsenal(),
                                        cursorColor: Colors.black,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (messageController.text.isEmpty) {
                                      } else {
                                        chat
                                            .doc(chatId)
                                            .collection("messages")
                                            .add({
                                          "msg": messageController.text,
                                          "createdOn":
                                              FieldValue.serverTimestamp(),
                                          "sender": widget.currentUserUid,
                                        }).then((value) {
                                          messageController.clear();
                                        });
                                      }
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Center(
                                        child: Icon(
                                          Icons.send,
                                          size: 30.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: SpinKitWave(
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: SpinKitWave(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      );
    }
  }
}
