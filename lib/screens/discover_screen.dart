import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_icon.dart';
import 'package:date_ug/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverScreen extends StatefulWidget {
  final String uid;
  final String gender;
  final String name;
  const DiscoverScreen(
      {Key? key, required this.uid, required this.gender, required this.name})
      : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "DISCOVER",
          hasActions: true,
          hasBackButton: false,
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where("gender", isNotEqualTo: widget.gender)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: GoogleFonts.arsenal(),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: SpinKitWave(
                    color: Colors.black,
                  ),
                );
                ;
              } else if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        snapshot.data!.docs[index]
                                            ["photoUrlList"][0],
                                      ),
                                    ),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(25.0)),
                                width: 300.0,
                                height: 500.0,
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 40.0,
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name: ${snapshot.data!.docs[index]["userName"]}",
                                            style: GoogleFonts.arsenal(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Age: ${snapshot.data!.docs[index]["age"]}",
                                        style: GoogleFonts.arsenal(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Location: ${snapshot.data!.docs[index]["location"]}",
                                        style: GoogleFonts.arsenal(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 16.0,
                                left: 240.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => ChatScreen(
                                              currentUserUid: widget.uid,
                                              friendName: snapshot.data!
                                                  .docs[index]["userName"],
                                              friendUid: snapshot
                                                  .data!.docs[index]["uid"],
                                              currentUserName: widget.name,
                                            )),
                                      ),
                                    );
                                  },
                                  child: const CustomIcon(
                                      color: Colors.red,
                                      icon: Icons.favorite,
                                      hasGradient: false),
                                )),
                          ],
                        ),
                      );
                    });
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
