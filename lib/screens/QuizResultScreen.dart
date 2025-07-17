import 'package:quiz_application/app_Config.dart';

class ResultScreen extends GetView<QuizController> {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = controller.score.value;
    final int total = controller.questions.length;
    final double percent = score / total;

    String getTitle() {
      if (percent >= 0.8) return "Excellent!";
      if (percent >= 0.5) return "Good Job!";
      return "Try Again!";
    }

    Color getColor() {
      if (percent >= 0.8) return Colors.green;
      if (percent >= 0.5) return Colors.orange;
      return Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Center(
                  child: Image.asset(
                    'assets/wow-emoji.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              30.height,
              Text(
                getTitle(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: getColor(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "You answered $score out of $total questions correctly",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  controller.resetQuiz();
                  Get.back();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.replay_rounded, size: 20),
                    SizedBox(width: 10),
                    Text("Try Again"),
                  ],
                ),
              ),
              10.height,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  controller.resetQuiz(isStartNew: true);
                  Get.back();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.start, size: 20),
                    SizedBox(width: 10),
                    Text("Start New Quiz"),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

