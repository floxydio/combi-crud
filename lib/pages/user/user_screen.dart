import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitetodo/view_model/profile_random_vm.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  initState() {
    super.initState();
    Provider.of<ProfileRandomViewModel>(context, listen: false).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ProfileRandomViewModel>(
        builder: (context, profileRandomVM, _) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                    profileRandomVM.dataProfile?.picture?.medium ?? "")),
            SizedBox(
              height: 20,
            ),
            Text(
                "${profileRandomVM.dataProfile?.name?.first} ${profileRandomVM.dataProfile?.name?.last}"),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.email),
                Text(profileRandomVM.dataProfile?.email ?? "")
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.phone_android),
                Text(profileRandomVM.dataProfile?.phone ?? "")
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.location_city),
                Text(profileRandomVM.dataProfile?.location?.city ?? "")
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileRandomVM.dataProfile?.gender == "female"
                    ? Icon(Icons.woman)
                    : Icon(Icons.man),
                Text(profileRandomVM.dataProfile?.gender ?? "")
              ],
            )
          ]),
        ),
      ));
    }));
  }
}
