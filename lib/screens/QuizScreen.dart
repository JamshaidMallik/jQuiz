import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiz_application/screens/QuizStartScreen.dart';
import '../app_Config.dart';


class QuizScreen extends GetView<QuizController> {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Game"),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.swap_calls),
            onPressed: () {
              Get.to(() => QuizStartScreen());
            },
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              controller.resetQuiz();
            },
          ),
          10.width,
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return GetPlatform.isIOS
              ? const Center(child: CupertinoActivityIndicator())
              : const Center(child: CircularProgressIndicator());
        } else if (controller.questions.isEmpty) {
          return const Center(child: Text("No questions available"));
        }
        final question = controller.questions[controller.currentIndex.value];
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value:
                    (controller.currentIndex.value + 1) /
                    controller.questions.length,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blueAccent,
                minHeight: 8,
              ),
              16.height,
              // Question Number and Category
              Text(
                "Question ${controller.currentIndex.value + 1}/${controller.questions.length}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ).paddingSymmetric(horizontal: 16),
              10.height,
              // Question Card
              Container(
                width: kSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 12,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.help_outline_rounded,
                          color: Colors.blueAccent,
                          size: 28,
                        ),
                        12.height,
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
              30.height,
              // Answer Options
              Expanded(
                child: ListView.separated(
                  itemCount: question.allAnswers.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    final answer = question.allAnswers[index];
                    return GestureDetector(
                      onTap: () async {
                        if (controller.selectedAnswer.value.isNotEmpty) return;
                        if (answer == question.correctAnswer) {
                          try {
                            HapticFeedback.lightImpact();
                          } catch (e) {
                            debugPrint('Haptic feedback failed: $e');
                          }
                        } else {
                          try {
                            HapticFeedback.heavyImpact(); // Wrong = stronger feedback
                          } catch (e) {
                            debugPrint('Haptic feedback failed: $e');
                          }
                        }
                        controller.selectedAnswer.value = answer;
                        await Future.delayed(Duration(milliseconds: 500));
                        controller.checkAnswer(answer);
                        await Future.delayed(Duration(milliseconds: 500));
                      },
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: controller.selectedAnswer.value.isNotEmpty
                                ? question.correctAnswer == answer
                                      ? Colors.green.shade100
                                      : controller.selectedAnswer.value ==
                                            answer
                                      ? Colors.red.shade100
                                      : Colors.white
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                controller.selectedAnswer.value.isNotEmpty
                                    ? question.correctAnswer == answer
                                          ? Icons.check_circle
                                          : controller.selectedAnswer.value ==
                                                answer
                                          ? Icons.cancel
                                          : Icons.circle_outlined
                                    : Icons.circle_outlined,
                                color:
                                    controller.selectedAnswer.value.isNotEmpty
                                    ? question.correctAnswer == answer
                                          ? Colors.green
                                          : controller.selectedAnswer.value ==
                                                answer
                                          ? Colors.red
                                          : Colors.grey
                                    : Colors.grey,
                              ),
                              12.width,
                              Expanded(
                                child: Text(
                                  answer,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        controller
                                            .selectedAnswer
                                            .value
                                            .isNotEmpty
                                        ? question.correctAnswer == answer
                                              ? Colors.green.shade800
                                              : controller
                                                        .selectedAnswer
                                                        .value ==
                                                    answer
                                              ? Colors.red.shade800
                                              : Colors.black
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).paddingSymmetric(horizontal: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
