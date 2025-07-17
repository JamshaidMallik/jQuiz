import 'package:http/http.dart' as http;
import 'package:quiz_application/models/QuizModel.dart';
import 'package:quiz_application/screens/QuizResultScreen.dart';
import '../app_Config.dart';

class QuizController extends GetxController {
  var questions = <Question>[].obs;
  var currentIndex = 0.obs;
  var score = 0.obs;
  var isLoading = false.obs;
  var selectedAnswer = ''.obs;
  var isAnswering = false.obs;
  var selectedQuizAmount = 10.obs;

  Future<void> fetchQuestions() async {
    debugPrint('Fetching questions...: ${selectedQuizAmount.value}');
    isLoading.value = true;
    try {
      final url = 'https://opentdb.com/api.php?amount=${selectedQuizAmount.value}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        questions.value = List<Question>.from(
          data['results'].map((q) => Question.fromMap(q)),
        );
      }
    } catch (e) {
      debugPrint('Error fetching questions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void checkAnswer(String answer) async {
    if (isAnswering.value) return;
    isAnswering.value = true;
    selectedAnswer.value = answer;
    if (questions[currentIndex.value].correctAnswer == answer) {
      score++;
      await SoundService.playCorrectSound();
    }else{
      await SoundService.playWrongSound();
    }
    await Future.delayed(const Duration(seconds: 1));
    selectedAnswer.value = '';
    isAnswering.value = false;

    if (currentIndex.value < questions.length - 1) {
      currentIndex++;
    } else {
      Get.to(()=> ResultScreen());
    }
  }

  void resetQuiz({bool isStartNew = false}) {
    currentIndex.value = 0;
    score.value = 0;
    selectedAnswer.value = '';
    isAnswering.value = false;
    if(isStartNew == true){
      questions.clear();
      fetchQuestions();
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }
}
