import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_row_for-profile.dart';
import 'package:date_ug/screens/log_in_screen.dart';
import 'package:date_ug/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference user = FirebaseFirestore.instance.collection("Users");
  String currentUserUid = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    dynamic uid = Provider.of<AuthService>(context, listen: false).getUid();
    await user.where("uid", isEqualTo: uid).get().then((value) {
      dynamic data = value.docs.single.data();
      setState(() {
        currentUserUid = data["uid"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(currentUserUid);
    return Scaffold(
      appBar: CustomAppBar(
        title: "DATE UG",
        hasActions: true,
        hasBackButton: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              user.where("uid", isEqualTo: currentUserUid).limit(1).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Something went wrong",
                  style: GoogleFonts.arsenal(),
                ),
              );
            } else if (snapshot.hasData) {
              dynamic data = snapshot.data!.docs.single.data();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.height / 3.0,
                            height: MediaQuery.of(context).size.height / 3.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(data["photoUrlList"][0])),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const CustomRowForProfile(text: "User Name:"),
                      Text(
                        data["userName"],
                        style: GoogleFonts.arsenal(
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const CustomRowForProfile(text: "Location:"),
                      Text(
                        data["location"],
                        style: GoogleFonts.arsenal(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const CustomRowForProfile(text: "Interests"),
                      Text(
                        data["interests"].join(','),
                        style: GoogleFonts.arsenal(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      CustomButton(
                          buttonText: "Log Out",
                          buttonFunction: () {
                            Provider.of<AuthService>(context, listen: false)
                                .signOut()
                                .then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const LogInScreen()),
                                ),
                              );
                            });
                          }),
                    ],
                  ),
                ),
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
    );
  }
}
