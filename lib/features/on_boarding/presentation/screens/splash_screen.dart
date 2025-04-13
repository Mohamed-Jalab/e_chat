import 'package:chat_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/features/chat/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants.dart';
import '../../../../core/routes.dart';
import '../../../../injection.dart' as di;
import '../widgets/splash_screen/animated_text.dart';
import '../widgets/splash_screen/clippers/colored_image_clipper.dart';
import '../widgets/splash_screen/clippers/image_clipper.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controllerForColoredImage;
  late AnimationController controllerForImage;
  late Animation curveForColoredImage;
  late Animation curveForImage;
  double? posOfImage;
  double sizeOfImage = 150;
  bool showText = false;
  @override
  void initState() {
    super.initState();
    //! Here to get the size of the pysical size of the
    //! device like (MediaQuery.sizeOf(context))
    //!---------------------------------------------------------------------------
    // final MediaQueryData mediaQuery = (context
    //         .getElementForInheritedWidgetOfExactType<MediaQuery>()
    //         ?.widget as MediaQuery)
    //     .data;
    // final Size physicalSize = mediaQuery.size * mediaQuery.devicePixelRatio;
    //! or use this
    // final physicalSize = PlatformDispatcher.instance.views.first.physicalSize;
    // final largestPhysicalSize = PlatformDispatcher.instance.views
    //     .map((v) => v.physicalSize)
    //     .reduce((curr, next) =>
    //         curr.width * curr.height > next.width * next.height ? curr : next);
    //!---------------------------------------------------------------------------
    controllerForColoredImage = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
        value: 1.0,
        lowerBound: 0);
    controllerForImage = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
        value: 1.0,
        lowerBound: 0.0);
    curveForColoredImage = CurvedAnimation(
        parent: controllerForColoredImage, curve: Curves.bounceIn);
    curveForImage =
        CurvedAnimation(parent: controllerForImage, curve: Curves.bounceIn);
    Future.delayed(const Duration(milliseconds: 1000), () {
      controllerForColoredImage.reverse();
      controllerForImage.reverse();
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      showText = true;
      sizeOfImage = 100;
      if (context.mounted) {
        posOfImage = MediaQuery.sizeOf(context).width / 2 - 117;
      }
      setState(() {});
      Future.delayed(const Duration(milliseconds: 1000), () async {
        bool isOnboardVisited =
            di.sl<SharedPreferences>().getBool(Constants.isOnboardVisited) ??
                false;
        bool isRemembered =
            di.sl<SharedPreferences>().getBool(Constants.isRemembered) ?? false;
        print("=====isOnboardVisited = $isOnboardVisited=====");
        print("=====isRemembered = $isRemembered=====");
        if (mounted) {
          Navigator.pushReplacement(
              context,
              //! TODO: different duartions I don't know why
              SildRightPageRouteWithCustomAnimation(
                  //! TODO: should bet (Supabase.instance.client.auth.currentUser != null &&
                  //!        isRemembered)
                  page: 
                  // Supabase.instance.client.auth.currentUser != null &&
                          isRemembered
                      ? const HomeScreen()
                      : (isOnboardVisited
                          ? const LoginScreen()
                          : const OnboardingScreen())));
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerForColoredImage.dispose();
    controllerForImage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("===splash_screen.dart===");

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              right: posOfImage ?? size.width / 2 - 85,
              top: size.height * .28,
              child: Row(
                children: [
                  //! I put Builder to refresh this section just.
                  AnimatedBuilder(
                      animation: curveForColoredImage,
                      builder: (context, _) {
                        return AnimatedContainer(
                          width: sizeOfImage,
                          duration: const Duration(milliseconds: 400),
                          child: ClipPath(
                            clipper: ColoredImageClipper(
                                value: curveForColoredImage.value),
                            child: const Image(
                              width: 150,
                              image: AssetImage(
                                  'assets/images/Logo E-Chat Colored.png'),
                            ),
                          ),
                        );
                      }),
                  AnimatedText(showText: showText),
                ],
              ),
            ),
            Positioned(
              width: size.width,
              top: size.height * .28,
              child: Row(
                children: [
                  const Spacer(),
                  AnimatedBuilder(
                      animation: curveForImage,
                      builder: (context, child) {
                        return ClipPath(
                          clipper: ImageClipper(value: curveForImage.value),
                          child: const Image(
                              image:
                                  AssetImage('assets/images/Logo E-Chat.png'),
                              width: 170),
                        );
                      }),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
