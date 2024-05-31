import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'intro_pages/intro_page_1.dart';
import 'intro_pages/intro_page_2.dart';
import 'intro_pages/intro_page_3.dart'; // Import the go_router package

// Define a StateNotifier for onboarding
final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>(
        (ref) => OnboardingNotifier());

// Define a State class for onboarding
class OnboardingState {
  final int currentPage;
  final bool onLastPage;

  OnboardingState({required this.currentPage, required this.onLastPage});

  OnboardingState copyWith({int? currentPage, bool? onLastPage}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      onLastPage: onLastPage ?? this.onLastPage,
    );
  }
}

// Define a StateNotifier class for onboarding
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier()
      : super(OnboardingState(currentPage: 0, onLastPage: false));

  void setCurrentPage(int page) {
    state = state.copyWith(currentPage: page, onLastPage: page == 2);
  }
}

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final onboardingNotifier = ref.read(onboardingNotifierProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              onboardingNotifier.setCurrentPage(index);
            },
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return IntroPage1();
                case 1:
                  return IntroPage2();
                case 2:
                  return IntroPage3();
                default:
                  return Container();
              }
            },
          ),

          // Dot indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip
                GestureDetector(
                  onTap: () {
                    context.go('/signup_page'); // Use context.go for navigation
                    onboardingNotifier.setCurrentPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 65, 65),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),

                // Next or Done
                onboardingState.onLastPage
                    ? GestureDetector(
                        onTap: () {
                          context.go('/signup_page'); // Use context.go for navigation
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Color.fromARGB(255, 95, 65, 65),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          onboardingNotifier
                              .setCurrentPage(onboardingState.currentPage + 1);
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Color.fromARGB(255, 95, 65, 65),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
