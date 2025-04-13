import 'package:flutter/material.dart';

import '../../../../core/images.dart';
import 'add_friend_text_field.dart';
import 'common_app_bar.dart';
import 'contact_for_search.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Stack(
        alignment: Alignment.center,
        children: [
          //! body
          // const Positioned(top: 0, child: Container(width: )),
          // const Positioned(bottom: 0, child: NavBar()),
          Positioned(top: 0, child: AddFriendTextField()),
          Positioned(top: 0, child: ContactsResult()),
          //! appBar
          Positioned(top: 0, child: AppBarForShadow()),
          Positioned(top: 0, child: CommonAppBar()),
          //! navBar
          //  Positioned(bottom: 0 - paddingBottom, child: NavBar()),
        ],
      ),
    );
  }
}

class ContactsResult extends StatelessWidget {
  const ContactsResult({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
        padding: EdgeInsets.only(top: size.height * .129 + 32 + 56 + 12),
        child: FutureBuilder(
            future: Future<bool>.delayed(
                const Duration(milliseconds: 1000), () => true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Something went wrong.",
                          style: TextStyle(fontSize: 16)),
                      ElevatedButton(
                          child: const Text("Try again"),
                          onPressed: () {
                            print('Try again');
                          }),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return false
                    ? const Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: Image(
                          image: AssetImage(AppImages.cardSearch),
                        ))
                    : SizedBox(
                        width: size.width,
                        height: size.height - (size.height * .246),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 12),
                            itemCount: 10,
                            itemBuilder: (context, index) => ContactWithIcon(
                                icon: const Icon(Icons.person_add_outlined,
                                    color: Color(0xFF40C4FF), size: 26),
                                onTap: () {})));
              }
              return const SizedBox();
            }));
  }
}

class AppBarForShadow extends StatelessWidget {
  const AppBarForShadow({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * .129,
      decoration: const BoxDecoration(color: Color(0xFF135CAF), boxShadow: [
        BoxShadow(
            color: Color(0x26000000), offset: Offset(0, 0), blurRadius: 20)
      ]),
    );
  }
}
