import 'package:flutter/material.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 30, size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class StartupViewModel {
  late AnimationController _controller;
  late Animation<Offset> slideUpAnimation;
  late Animation<double> fadeInAnimation;

  void initializeAnimations(TickerProvider vsync) {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    );

    slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  void enableInteraction() {
    _controller.forward();
  }

  void dispose() {
    _controller.dispose();
  }
}

class _GetStartedViewState extends State<GetStartedView>
    with SingleTickerProviderStateMixin {
  late StartupViewModel startupViewModel;

  @override
  void initState() {
    super.initState();
    startupViewModel = StartupViewModel();
    startupViewModel.initializeAnimations(this);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        startupViewModel.enableInteraction();
      });
    });
  }

  @override
  void dispose() {
    startupViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.lightBlueAccent,
                  child: Column(
                    children: [
                      const SizedBox(height: 130.0),
                      Hero(
                        tag: 'logo_with_slogan_tag',
                        child: Image.asset(
                          'assets/images/slogun.png',
                          width: 140.0,
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SlideTransition(
                            position: startupViewModel.slideUpAnimation,
                            child: FadeTransition(
                              opacity: startupViewModel.fadeInAnimation,
                              child: Image.asset(
                                'assets/images/home_background.png',
                              ),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35.0),
              FadeTransition(
                opacity: startupViewModel.fadeInAnimation,
                child: Text(
                  'Effortless Parking at Your Fingertips!',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: FadeTransition(
                    opacity: startupViewModel.fadeInAnimation,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/started2');
                            },
                            child: Text('Login'),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: Text('Skip'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: FadeTransition(
              opacity: startupViewModel.fadeInAnimation,
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/images/startup.png',
                    width: 120.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
