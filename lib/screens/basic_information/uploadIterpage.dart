import 'package:flutter/material.dart';

class UploadItrPage extends StatefulWidget {
  final Function(String, String) onUpload;

  const UploadItrPage({required this.onUpload, Key? key}) : super(key: key);

  @override
  _UploadItrPageState createState() => _UploadItrPageState();
}

class _UploadItrPageState extends State<UploadItrPage> {
  late TextEditingController itrNumberController;
  late String attachment = '';

  @override
  void initState() {
    super.initState();
    itrNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload ITR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: itrNumberController,
              decoration: const InputDecoration(labelText: 'Enter ITR Number'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Open gallery or camera to pick an image
                // For simplicity, we're using a placeholder value here
                String pickedImage = 'path/to/picked_image.jpg';

                setState(() {
                  attachment = pickedImage;
                });
              },
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Validate and upload ITR details
                if (itrNumberController.text.isNotEmpty &&
                    attachment.isNotEmpty) {
                  widget.onUpload(itrNumberController.text, attachment);
                } else {
                  // Handle validation error
                  // Show an error message or take appropriate action
                }
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
