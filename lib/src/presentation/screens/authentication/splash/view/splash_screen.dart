import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final SplashController splashController = Get.find<SplashController>();
  final settingsService = Get.find<SettingsService>();

  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _merchantController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _backgroundFadeAnimation;

  late Animation<double> _merchantFadeAnimation;
  late Animation<Offset> _merchantSlideAnimation;

  @override
  void initState() {
    super.initState();
    settingsService.isSettingsDataLoad.value = false;
    settingsService.fetchSettings();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.ease));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.ease));

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, -1.2),
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -1.2),
          end: const Offset(0, 0.1),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 15,
      ),
    ]).animate(_logoController);

    _logoController.forward();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _textFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _backgroundFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeIn),
    );

    _merchantController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _merchantFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _merchantController, curve: Curves.easeIn),
    );

    _merchantSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _merchantController,
            curve: Curves.easeOutBack,
          ),
        );

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _backgroundController.forward();
        _merchantController.forward();
      }
    });

    ever(settingsService.isSettingsDataLoad, (isLoaded) {
      if (isLoaded == true) {
        Future.delayed(const Duration(seconds: 2), () {
          splashController.navigateBasedOnAuth();
        });
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _merchantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          Stack(
            children: [
              FadeTransition(
                opacity: _backgroundFadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(PngAssets.splashFrame),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                PngAssets.appScreenIcon,
                                height: 50.h,
                              ),
                              // SizedBox(width: 4.w),
                              // FadeTransition(
                              //   opacity: _textFadeAnimation,
                              //   child: SlideTransition(
                              //     position: _textSlideAnimation,
                              //     child: Text(
                              //       "ara",
                              //       style: TextStyle(
                              //         letterSpacing: 0,
                              //         fontSize: 60.sp,
                              //         fontWeight: FontWeight.w900,
                              //         color: AppColors.lightTextPrimary,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _merchantFadeAnimation,
                      child: SlideTransition(
                        position: _merchantSlideAnimation,
                        child: Container(
                          margin: EdgeInsets.only(right: 22.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightPrimary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.splashAgentBadge,
                            style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(() {
            return Visibility(
              visible: settingsService.isSettingsLoading.value,
              replacement: SizedBox(),
              child: Transform.translate(
                offset: Offset(0, -80),
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.lightPrimary,
                  size: 50,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
