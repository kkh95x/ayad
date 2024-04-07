import 'package:flutter/material.dart';

enum AnimationType { scall, slide, fade, rotat }

class ChildWrpperWithAnimation extends StatefulWidget {
  const ChildWrpperWithAnimation(
      {super.key,
      required this.child,
      this.wantKeepAlive = true,
      this.addFadeWidthAllAnimationWithoutFade = false,
      this.duration = const Duration(milliseconds: 300),
      this.animationTypes = const <AnimationType>{AnimationType.slide}});
  final Duration duration;
  final Widget child;
  final bool wantKeepAlive;
  //you can mix with multi animation
  final Set<AnimationType> animationTypes;
  final bool addFadeWidthAllAnimationWithoutFade;
  @override
  State<ChildWrpperWithAnimation> createState() =>
      _ChildWrpperWithAnimationState();
}

class _ChildWrpperWithAnimationState extends State<ChildWrpperWithAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _rotateAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final firstType = widget.animationTypes.firstOrNull ?? AnimationType.slide;
    Widget child = _getTargetAnimation(firstType, widget.child);
    if (widget.animationTypes.length > 1) {
      for (var type in widget.animationTypes
          .toList()
          .getRange(1, widget.animationTypes.length)) {
        child = _getTargetAnimation(type, child);
      }
    }
    return child;
  }

  Widget _getTargetAnimation(AnimationType animationType, Widget child) {
    switch (animationType) {
      case AnimationType.scall:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: child,
        );
      case AnimationType.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: child,
        );
      case AnimationType.fade:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: child,
        );
      case AnimationType.rotat:
        return RotationTransition(
          turns: _rotateAnimation,
          child: child,
        );
    }
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}

//Slide Item -----------------------------------------------------------------------------------
