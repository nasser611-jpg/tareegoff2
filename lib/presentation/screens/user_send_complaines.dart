import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:tareegoff22/core/utils.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/screens/set_user_location.dart';
import 'package:tareegoff22/presentation/screens/user_complaines_screen.dart';

class UserSendComplainesScreen extends StatefulWidget {
  const UserSendComplainesScreen({
    super.key,
  });

  @override
  State<UserSendComplainesScreen> createState() =>
      _UserSendComplainesScreenState();
}

class _UserSendComplainesScreenState extends State<UserSendComplainesScreen> {
  final TextEditingController _desController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;
  bool _submitButtonPressed = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  File? file;
  String? url;
  late double? selectedLatitude;
  double? selectedLongitude;
  String? selectedAddress;
  void _showPickOptionsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  CollectionReference user =
      FirebaseFirestore.instance.collection('categories');

  addCategory() async {
    try {
      DocumentReference response = await user.add({
        'email': FirebaseAuth.instance.currentUser!.email,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'displayName':
            FirebaseAuth.instance.currentUser!.displayName ?? 'غير محدد'
      });
    } catch (e) {
      print('Erorr $e');
    }
  }

  Future<void> _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (image != null) {
      file = File(image.path);
      var imageName = path.basename(image.path);
      var refStoreage = FirebaseStorage.instance.ref('images/$imageName');
      await refStoreage.putFile(file!);
      url = await refStoreage.getDownloadURL();

      setState(() {
        _imageFile = image;
      });

      setState(() {
        _imageFile = image;
      });
    }
  }

  Future<void> _imgFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (image != null) {
      file = File(image.path);
      var imageName = path.basename(image.path);
      var refStoreage = FirebaseStorage.instance.ref('images/$imageName');
      await refStoreage.putFile(file!);
      url = await refStoreage.getDownloadURL();

      setState(() {});
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  void dispose() {
    _desController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _desController.selection = TextSelection.fromPosition(
      TextPosition(offset: _desController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('اضافة شكوى', Icons.add),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(20),
              alignment: Alignment.topRight,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'الوصــــــف ',
                      style: Styles.textStyle12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 2),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        maxLines: 4,
                        maxLength: 120,
                        controller: _desController,
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          suffix: const Icon(
                            Icons.description,
                            color: Color.fromARGB(255, 147, 142, 142),
                          ),
                          border: InputBorder.none,
                          hintText: 'الوصف',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: Styles.textStyle30Title.copyWith(
                            color: const Color.fromARGB(255, 147, 142, 142),
                            fontSize: 18,
                          ),
                          errorText: _errorText,
                        ),
                        validator: (value) {
                          if (_submitButtonPressed && value!.isEmpty) {
                            return 'الوصف مطلوب';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _errorText =
                                null; // Clear error text when user starts typing
                          });
                        },
                      ),
                    ),
                    if (_errorText != null)
                      Text(
                        _errorText!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0100,
                    ),
                    const Text(
                      '  التوقيـــــت',
                      style: Styles.textStyle12,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.0700,
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 2),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        formattedDateTime,
                        style: Styles.titlePage.copyWith(
                          color: const Color.fromARGB(185, 7, 7, 7),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Text(
                      '  اختيار صوره',
                      style: Styles.textStyle12,
                      textAlign: TextAlign.start,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPickOptionsDialog();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.0700,
                        width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3), width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 85, 117, 170),
                        ),
                      ),
                    ),
                    Center(
                      child: _imageFile == null
                          ? const Text(
                              'لم يتم اختيار اي صوره',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 142, 24, 16)),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height *
                                  0.5, // For example, half the screen height
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: url != null
                                          ? Colors.green
                                          : Colors.redAccent)
                                ],
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(File(_imageFile!.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    const Text(
                      '   الموقـــع',
                      style: Styles.textStyle12,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        alignment: Alignment.center,
                        height: selectedAddress == null ? 40 : 70,
                        width: selectedAddress == null ? 150 : 320,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 193, 197, 206)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              final mapData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapScreen()),
                              );
                              if (mapData != null) {
                                selectedAddress = mapData['selectedAddress'];
                                selectedLatitude = mapData['selectedLatitude'];
                                selectedLongitude =
                                    mapData['selectedLongitude'];
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedAddress == null
                                  ? 'اختيار الموقع'
                                  : selectedAddress.toString(),
                              style: Styles.titlePage
                                  .copyWith(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              _submitButtonPressed = true;
            });

            if (_desController.text.isEmpty) {
              setState(() {
                _errorText = 'الرجاء إدخال الوصف';
              });
            } else if (selectedAddress == null) {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: true,
                      title: 'عفواً',
                      desc: 'الرجاء اختيار الموقع !...',
                      btnOkOnPress: () {},
                      btnOkText: 'حسناً')
                  .show();
            } else if (_formKey.currentState!.validate()) {
              try {
                addCategory();
                CollectionReference collNote = FirebaseFirestore.instance
                    .collection('categories')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('note');

                DocumentReference response = await collNote.add({
                  'des': _desController.text,
                  'url': url ?? "none",
                  'address': selectedAddress,
                  'lat': selectedLatitude,
                  'long': selectedLongitude,
                  'time': formattedDateTime,
                  'state': 'قيد المراجعه'
                });
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        headerAnimationLoop: true,
                        title: 'جميل',
                        desc: 'تم الرفع بنجاح   !...',
                        btnOkOnPress: () {},
                        btnOkText: 'حسناً')
                    .show()
                    .then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserComplainesScreen(),
                      ));
                });
              } catch (e) {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        headerAnimationLoop: true,
                        title: 'عفواً',
                        desc: 'الرجاء تاكد من جودة الانترنت لديك  !...',
                        btnOkOnPress: () {},
                        btnOkText: 'حسناً')
                    .show();
                print('Erorr $e');
              }
            }
          },
          child: Container(
            height: 59,
            width: 308,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: InkWell(
                onTap: () {},
                child: Text(
                  'ارسال',
                  style: Styles.textStyle30Title
                      .copyWith(color: const Color.fromARGB(255, 38, 146, 204)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
