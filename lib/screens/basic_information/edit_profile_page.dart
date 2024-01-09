import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krishajdealer/providers/Profile/basic_info_provider.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/services/api/edit_user_info_responce_model.dart';
import 'package:krishajdealer/services/api/user_basic_info_responce_model.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final UserInfoMessage? userData;
  const EditProfilePage({required this.userData, Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController altMobileController;
  late TextEditingController dobController;
  late TextEditingController anniversaryController;
  late TextEditingController itrNumberController;
  late TextEditingController _imagePathController; // Controller for image path
  late TextEditingController _pdfPathController; // Controller for PDF path

  File? _image;
  File? _pdf;
  bool _isLoading = false; // Added variable to track loading state
  @override
  void initState() {
    super.initState();
    mobileController =
        TextEditingController(text: widget.userData?.mobileNumber ?? '');
    emailController = TextEditingController(text: widget.userData?.email ?? '');
    altMobileController =
        TextEditingController(text: widget.userData?.alternativeMobileNo ?? '');
    dobController =
        TextEditingController(text: widget.userData?.dateOfBirth ?? '');
    anniversaryController =
        TextEditingController(text: widget.userData?.anniversaryDate ?? '');
    itrNumberController =
        TextEditingController(text: widget.userData?.itrNumber ?? '');
    _imagePathController =
        TextEditingController(); // Initialize image path controller
    _pdfPathController =
        TextEditingController(); // Initialize PDF path controller

    // // Check if the API response contains a non-null value for itrImage
    // if (widget.userData?.itrImage != null) {
    //   _image = File(widget.userData!.itrImage!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelTextField(
                  labelText: 'Mobile',
                  controller: mobileController,
                ),
                const SizedBox(height: 16.0),
                LabelTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                ),
                const SizedBox(height: 16.0),
                LabelTextField(
                  labelText: 'Alternative Mobile no',
                  controller: altMobileController,
                ),
                const SizedBox(height: 16.0),
                LabelTextField(
                  labelText: 'DOB',
                  controller: dobController,
                  readOnly: true,
                  onTap: () => _selectDate(context, dobController),
                ),
                const SizedBox(height: 16.0),
                LabelTextField(
                  labelText: 'Anniversary Date',
                  controller: anniversaryController,
                  readOnly: true,
                  onTap: () => _selectDate(context, anniversaryController),
                ),
                const SizedBox(height: 16.0),
                LabelTextField(
                  labelText: 'Enter ITR Number',
                  controller: itrNumberController,
                ),
                const SizedBox(height: 16.0),
                Container(
                  // Wrapping the Row with a Container
                  color: Colors.green[200],
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Upload your ITR attachment:${widget.userData?.itrSubmit ?? ''}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => _pickFile(ImageSource.gallery),
                            child: Text('Gallery'),
                          ),
                          ElevatedButton(
                            onPressed: () => _pickFile(ImageSource.camera),
                            child: Text('Camera'),
                          ),
                          ElevatedButton(
                            onPressed: _pickPDF,
                            child: Text('Pick PDF'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Container(
                    color: Colors.green[200],
                    width: double.infinity,
                    height: 200.0, // Set the desired height
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.contain,
                          )
                        : (_pdf != null
                            ? Text('Picked PDF: ${_pdf!.path}')
                            : Text('No image or PDF picked')),
                  ),
                ),
                //     child: widget.userData?.itrImage != null
                //         ? _image != null
                //             ? Image.file(
                //                 _image!,
                //                 fit: BoxFit.contain,
                //               )
                //             : Container() // Display selected image
                //         : Container(), // Display a blank container if no image is available
                //   ),
                // ),
                // _pdf != null ? Text('Picked PDF: ${_pdf!.path}') : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: _uploadData,
              icon: Icons.save,
              text: 'Upload Data',
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadData() async {
    try {
      setState(() {
        _isLoading = true; // Set loading state to true
      });
      String? token = await AuthState().getToken();
      String email = emailController.text;
      String alternativeMobileNo = altMobileController.text;
      String dateOfBirth = dobController.text;
      String anniversaryDate = anniversaryController.text;
      String itrSubmit = widget.userData?.itrSubmit ?? '';
      String itrNumber = itrNumberController.text;
      File? selectedFile;
      // Show loading indicator
      // You can implement a loading indicator based on your UI design
      if (_image != null) {
        selectedFile = _image;
      } else if (_pdf != null) {
        selectedFile = _pdf;
      }
      // Call the editUserInfo function from UserInfoProvider
      EditUserInfoResponse response = await UserInfoProvider().editUserInfo(
        context,
        token!,
        email,
        alternativeMobileNo,
        dateOfBirth,
        anniversaryDate,
        itrSubmit,
        itrNumber,
        selectedFile,
      );

      // Show success toast
      _showToast(context, response.message, false);

      // You can also navigate to another screen or perform other actions on success
    } catch (e) {
      // Handle errors
      _showToast(context, 'Error occurred: $e', true);
    }finally {
    setState(() {
      _isLoading = false; // Set loading state back to false after API call
    });
  }
}
  void _showToast(BuildContext context, String message, bool isError) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
    )..show(context);
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    // Parse the existing date string
    DateTime initialDate = DateTime.tryParse(controller.text) ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Format the picked date and set it in the controller
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pdf = File(result.files.single.path!);
          _pdfPathController.text = _pdf!.path;
        });
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }

  Future<void> _pickFile(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _imagePathController.text = _image!.path;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }
}

class LabelTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool readOnly;
  final GestureTapCallback? onTap;

  const LabelTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.green),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
