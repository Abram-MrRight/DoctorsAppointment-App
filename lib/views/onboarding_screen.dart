import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/home_view/home.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  bool isLastPage = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 84),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              // _pageIndex = index;
              isLastPage = index == 2;
            });
          },
          itemCount: messageTiles.length,
          itemBuilder: (context, index) => OnboardContent(
              image: messageTiles[index].image,
              title: messageTiles[index].title,
              description: messageTiles[index].description
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)
                )
            ),
            backgroundColor: const Color(0xff1055e5),
            minimumSize: const Size.fromHeight(80)
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
              fontSize: 24
          ),
        ),
        onPressed: () async {
          // navigate to landing page
          final preference = await SharedPreferences.getInstance();
          preference.setBool('firstTimeUser', false);
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LoginView()
                )
            );
          }
        },
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 84,
        color: const Color(0xFF1055E5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                'SKIP',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () {
                _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut
                );
              },
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const WormEffect(
                  spacing: 16,
                  dotColor: Colors.blue,
                  activeDotColor: Colors.white,
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
              ),
            ),
            TextButton(
              child: const Text(
                'NEXT',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> messageTiles = [
  Onboard(
      image: Appassets.care,
      title: 'Exceptional Care',
      description: "Experience top-tier healthcare with our commitment to providing exceptional and personalized care for your well-being."
  ),
  Onboard(
      image: Appassets.answers,
      title: 'The Right Answers',
      description: "Discover a wealth of knowledge and find the right answers to your health-related questions through our comprehensive and reliable information."
  ),
  Onboard(
      image: Appassets.specialists,
      title: 'The Best Specialists',
      description: "Connect with the best specialists in the field who are dedicated to your health and well-being, ensuring you receive expert care tailored to your needs."
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 32,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1055E5),
              fontFamily: 'Segoe UI',
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFF1055E5),
                  fontSize: 16
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
