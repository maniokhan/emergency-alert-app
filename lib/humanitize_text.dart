import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TextHumanizationPage extends StatefulWidget {
  const TextHumanizationPage({super.key});

  @override
  _TextHumanizationPageState createState() => _TextHumanizationPageState();
}

class _TextHumanizationPageState extends State<TextHumanizationPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  Future<void> humanizeText(String text) async {
    final url = Uri.parse(
        'https://api-inference.huggingface.co/models/facebook/bart-large-cnn');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer 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',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'inputs': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      // Extract the humanized text from the response
      String humanizedText = data[0]['summary_text'].trim();
      
      // Remove the unwanted paragraph
      String unwantedParagraph = "For confidential support call the Samaritans on 08457 90 90 90, visit a local Samaritans branch or see www.samaritans.org.";
      if (humanizedText.contains(unwantedParagraph)) {
        humanizedText = humanizedText.replaceAll(unwantedParagraph, '').trim();
      }

      setState(() {
        _result = humanizedText;
      });
      print("Given Text Input ${_controller.text}");
      print("Output Text $_result");
    } else {
      print('Error: ${response.statusCode} : Error ${response.body}');
      setState(() {
        _result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Text Humanizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Enter text'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  humanizeText(_controller.text);
                },
                child: Text('Humanize Text'),
              ),
              SizedBox(height: 16),
              Text('Result: $_result'),
            ],
          ),
        ),
      ),
    );
  }
}

