import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const double kHorizontalPadding = 32;

Profile dummyProfile =
    Profile(); // Dummy profile. You'll want to bring in the real user's profile

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
          dummyProfile =
              dummyProfile.copyWith(profileImageUrl: pickedImage.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
      print('Failed to pick image: $e');
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user signed in')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print("User ID: ${user.uid}");

      // Upload profile image to Firebase Storage if an image is selected
      String? imageUrl;
      if (_image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(user.uid);
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() => null);
        imageUrl = await snapshot.ref.getDownloadURL();

        print("Image URL: $imageUrl");
      }

      // Update Firestore document
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.update({
        'firstName': dummyProfile.firstName ?? '',
        'lastName': dummyProfile.lastName ?? '',
        'location': dummyProfile.location ?? '',
        'bio': dummyProfile.bio ?? '',
        'profileImageUrl': imageUrl ?? dummyProfile.profileImageUrl,
      });

      print("Profile updated successfully");

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      // Close the profile screen
      Navigator.pop(context);
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            CupertinoButton(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Done',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              onPressed: _isLoading ? null : _updateProfile,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: 48),
        children: [
          Align(
            child: ProfilePicture(
              imageUrl: _image != null
                                   ? _image!.path
                  : dummyProfile.profileImageUrl ?? '',
              isLocalImage: _image != null,
            ),
          ),
          const SizedBox(height: 4),
          CupertinoButton(
            child: const Text(
              'Upload Image',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: _pickImage,
          ),
          const SizedBox(height: 48),
          ProfileInputField(
            inputLabel: 'First name',
            hintText: 'John',
            onChanged: (val) {
              setState(() {
                dummyProfile = dummyProfile.copyWith(firstName: val);
              });
            },
          ),
          ProfileInputField(
            inputLabel: 'Last name',
            hintText: 'Smith',
            onChanged: (val) {
              setState(() {
                dummyProfile = dummyProfile.copyWith(lastName: val);
              });
            },
          ),
          ProfileInputField(
            inputLabel: 'Location',
            hintText: 'Dallas',
            onChanged: (val) {
              setState(() {
                dummyProfile = dummyProfile.copyWith(location: val);
              });
            },
          ),
          ProfileInputField(
            inputLabel: 'Bio',
            maxTextfieldLines: 5,
            maxLength: 140,
            hintText: 'I like to be productive',
            onChanged: (val) {
              setState(() {
                dummyProfile = dummyProfile.copyWith(bio: val);
              });
            },
          ),
        ],
      ),
    );
  }
}

class ProfileInputField extends StatelessWidget {
  const ProfileInputField({
    this.inputLabel = '',
    this.hintText = '',
    this.maxTextfieldLines = 1,
    this.maxLength,
    required this.onChanged,
    super.key,
  });

  final String inputLabel;
  final String hintText;
  final int? maxLength;
  final int maxTextfieldLines;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                inputLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                maxLines: maxTextfieldLines,
                maxLength: maxLength,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          height: 32,
        ),
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    required this.imageUrl,
    this.isLocalImage = false,
    this.radius = 172,
    super.key,
  });

  final String imageUrl;
  final bool isLocalImage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: isLocalImage
          ? Image.file(
              File(imageUrl),
              height: radius,
              width: radius,
              fit: BoxFit.cover,
            )
          : Image.network(
              imageUrl.isNotEmpty ? imageUrl : avatarImageUrl,
              height: radius,
              width: radius,
              fit: BoxFit.cover,
            ),
    );
  }
}

class Profile {
  final String? profileImageUrl;
  final String? firstName;
  final String? lastName;
  final String? location;
  final String? bio;

  Profile({
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.location,
    this.bio,
  });

  @override
  String toString() {
    return '$firstName $lastName';
  }

  Profile copyWith({
    String? profileImageUrl,
    String? firstName,
    String? lastName,
    String? location,
    String? bio,
  }) {
    return Profile(
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      bio: bio ?? this.bio,
    );
  }
}

const avatarImageUrl =
    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'; // Default avatar URL

// const String defaultProfileImageUrl = 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
