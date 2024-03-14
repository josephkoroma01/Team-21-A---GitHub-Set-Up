import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/data/question_model.dart';
import 'package:lifebloodworld/features/Home/views/result_screen.dart';

import '../models/question_model.dart';

class MyQuiz extends StatefulWidget {
  const MyQuiz({super.key});

  @override
  State<MyQuiz> createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    fetchQuestions();
    startTimer();
  }


 Future<void> fetchQuestions() async {
    // Make your API call here to fetch questions
    // Replace 'YourAPI.fetchQuestions()' with your actual API call
    List<Question> fetchedQuestions = await TriviaAPI.fetchQuestions();

    setState(() {
      questions = fetchedQuestions;
    });
  }



  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  PageController? _controller = PageController(initialPage: 0);
  bool isPressed = false;
  Color isTrue = Colors.green;
  Color iswrong = Colors.red;
  Color btnColor = Color.fromARGB(255, 76, 175, 167);
  int score = 0;
  int timespent = 0;
  int seconds = 180;
  List<Question> questions = []; 

  Timer? timer;
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          navigateToResultScreen();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            controller: _controller!,
            onPageChanged: (Page) {
              setState(() {
                isPressed = false;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '${seconds} ',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: seconds / 60,
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Text(
                          'Question ${index + 1}/${questions.length}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                    ],
                  ),
                  Divider(
                    height: 8.0,
                    thickness: 2.0,
                    color: const Color.fromARGB(255, 76, 175, 150),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    questions[index].question!,
                    style: TextStyle(fontSize: 18, letterSpacing: 0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 18),
                      child: MaterialButton(
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        color: isPressed
                            ? questions[index]
                                    .answers!
                                    .entries
                                    .toList()[i]
                                    .value
                                ? isTrue
                                : iswrong
                            : kPrimaryColor.shade100,
                        onPressed: isPressed ? (){} : (){
                          setState(() {
                          isPressed = true;
                        });
                      if(questions[index].answers!.entries.toList()[i].value){
                        score+=1;
                        print(score);
                       
                      }
                        },
                        child: Text(
                          questions[index].answers!.keys.toList()[i],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: isPressed ? index + 1 == questions.length? (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen(score, (180 - seconds))));
                        } : (){
                          _controller!.nextPage(duration: Duration(microseconds: 500), curve: Curves.linear);
                        } : null,
                        style: ButtonStyle(

                        ),

                        child: Text(
                          index + 1 == questions.length ? "View result" : "Next Question",
                        )),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  void navigateToResultScreen() {
    // Calculate the score based on the number of questions answered
    int totalQuestions = questions.length;
    int calculatedScore = (score / (totalQuestions * 10) * 100).round();
    int timeremaing = (180 - seconds).round();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(calculatedScore, timeremaing)),
        (route) => false);
  }
}



class TriviaAPI{
  static Future<List<Question>> fetchQuestions() async {
    final url = Uri.parse('http://api.famcaresl.com/communityapp/index.php?route=lifebloodtrivia'); // Replace with your API endpoint

  // Perform the API request
  final response = await http.post(
    url,
    body: jsonEncode({
      "week": '1',
      "status": 'active',
    }),
    headers: {'Content-Type': 'application/json'},
  );

  // Handle the API response
  if (response.statusCode == 200) {
    // Decode the response body
    final List<dynamic> jsonResponse = json.decode(response.body);

    // Map JSON data to Question objects and return it
    return jsonResponse.map((json) => Question.fromJson(json)).toList();
  } else {
    // If the request was not successful, throw an exception
    throw Exception('Failed to load questions');
  }
   
  
}

}