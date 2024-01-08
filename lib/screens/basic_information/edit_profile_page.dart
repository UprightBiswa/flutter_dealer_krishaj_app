import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  // final Map<String, String> userData;
  final Function(Map<String, String>) onUpdate;

  const EditProfilePage(
      {required this.onUpdate, Key? key})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController altMobileController;
  late TextEditingController dobController;
  late TextEditingController anniversaryController;
  late TextEditingController itrnumberController;

  // @override
  // void initState() {
  //   super.initState();
  //   mobileController = TextEditingController(text: widget.userData['Mobile']);
  //   emailController = TextEditingController(text: widget.userData['E-mail']);
  //   altMobileController =
  //       TextEditingController(text: widget.userData['Alternative Mobile no']);
  //   dobController = TextEditingController(text: widget.userData['DOB']);
  //   anniversaryController =
  //       TextEditingController(text: widget.userData['Anniversary Date']);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.onUpdate({
                'Mobile': mobileController.text,
                'E-mail': emailController.text,
                'Alternative Mobile no': altMobileController.text,
                'DOB': dobController.text,
                'Anniversary Date': anniversaryController.text,
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
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
              labelStyle: const TextStyle(color: Colors.blue),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
