import 'package:quiz_application/screens/QuizScreen.dart';
import '../app_Config.dart';

class QuizStartScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());
  final List<int> options = [10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Get Ready!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  12.height,
                  const Text(
                    "Pick a number to begin your quiz journey!",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  24.height,
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: options.map((count) {
                      return InkWell(
                        onTap: () async {
                          controller.selectedQuizAmount.value = count;
                          Get.offAll(() => QuizScreen());
                          await controller.fetchQuestions();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            "$count Questions",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
