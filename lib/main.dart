import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Quelle commande permet de créer un projet Flutter ?',
      'options': ['flutter build', 'flutter create', 'flutter run', 'flutter init'],
      'answer': 'flutter create',
    },
    {
      'question': 'Quel widget est utilisé pour centrer un enfant ?',
      'options': ['Align', 'Column', 'Center', 'Container'],
      'answer': 'Center',
    },
    {
      'question': 'Quelle méthode démarre une application Flutter ?',
      'options': ['runApp()', 'startApp()', 'launchApp()', 'initApp()'],
      'answer': 'runApp()',
    },
    {
      'question': 'Quel widget est sans état (stateless) ?',
      'options': ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'StreamBuilder'],
      'answer': 'StatelessWidget',
    },
    {
      'question': 'Où se trouvent les dépendances dans un projet Flutter ?',
      'options': ['pubspec.yaml', 'AndroidManifest.xml', 'build.gradle', 'index.html'],
      'answer': 'pubspec.yaml',
    },
  ];

  void _checkAnswer(String selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Flutter'),
        backgroundColor: const Color.fromARGB(255, 134, 81, 127),
      ),
      body: _currentQuestionIndex < _questions.length
          ? _buildQuestion()
          : _buildResult(),
    );
  }

  Widget _buildQuestion() {
    var question = _questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question['question'] as String,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ...(question['options'] as List<String>).map((option) {
            return ElevatedButton(
              onPressed: () => _checkAnswer(option),
              child: Text(option),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Votre score : $_score / ${_questions.length}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
              });
            },
            child: Text('Rejouer'),
          ),
        ],
      ),
    );
  }
}
