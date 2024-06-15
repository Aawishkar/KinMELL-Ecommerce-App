import 'dart:io';

import 'package:app/models/user/User-Profile.dart';
import 'package:app/utils/user_preference.dart';
import 'package:app/views/home/widgets/appbar_widgets.dart';
import 'package:app/views/home/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User_Profile user;
  @override
  void initState() {
    super.initState();

    user = UserPreferance.getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imgPath: user.imgPath,
              isEdit: true,
              onClicked: () async {
                try {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (image == null) return;

                  final directory = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${directory.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);

                  setState(() => user = user.copy(imgPath: newImage.path));
                } catch (error) {
                  debugPrint(error.toString());
                }
              },
            ),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) => user = user.copy(name: name),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) => user = user.copy(email: email),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              label: 'Contact',
              text: user.contact,
              onChanged: (contact) => user = user.copy(contact: contact),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              label: 'Location',
              text: user.location,
              onChanged: (location) => user = user.copy(location: location),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              label: 'About',
              text: user.about,
              maxLines: 5,
              onChanged: (about) => user = user.copy(about: about),
            ),
            const SizedBox(height: 24),
            Center(
              child: ButtonWidget(
                text: 'Save',
                onClicked: () {
                  UserPreferance.setUser(user);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      );
}
