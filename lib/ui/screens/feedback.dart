import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration:const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: feedbackController,
              decoration:const InputDecoration(
                labelText: 'Feedback',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                
                _submitFeedback();
              },
              child:const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
 final Logger logger = Logger();

  void _submitFeedback() {
    final String name = nameController.text;
    final String feedback = feedbackController.text;

    if (name.isNotEmpty && feedback.isNotEmpty) {
  FirebaseFirestore.instance.collection('client').add({
    'Name': name,
    'Feedback': feedback,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    logger.d("Feedback Submitted");
  }).catchError((error) {
    logger.e("Failed to submit feedback: $error");
  });
}
    }
  }

