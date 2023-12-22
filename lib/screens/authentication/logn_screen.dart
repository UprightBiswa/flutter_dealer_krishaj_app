import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class FoochiSignInView extends StatefulWidget {
  const FoochiSignInView({Key? key}) : super(key: key);

  @override
  State<FoochiSignInView> createState() => _FoochiSignInViewState();
}

class _FoochiSignInViewState extends State<FoochiSignInView> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isIdCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: FadeAnimation(
            delay: 1,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(child: Image.asset(AppAssets.kAppLogo)),
                const SizedBox(height: 30),
                const Text('Sign In with Phone No',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.kSecondary)),
                const SizedBox(height: 23),
                AuthField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  isFieldValidated: isIdCorrect,
                  onChanged: (value) {
                    setState(() {});
                    isIdCorrect = validateId(value);
                  },
                  hintText: 'Your Customer Id',
                  validator: (value) {
                    if (!validateId(value!)) {
                      return 'Please enter a valid Customer Id';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthField(
                  hintText: 'Your Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  isForgetButton: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to FoochiSignInView when "Get Started" is tapped
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CustomBottomNavigationBar()),
                        );
                      }
                    },
                    text: 'Sign In'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateId(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      final idRegex = RegExp(r'^[0-9]+$');
      return idRegex.hasMatch(value);
    }
  }
}

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isFieldValidated;
  final bool isForgetButton;
  final bool isPasswordField;
  final bool isPhone;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.onChanged,
    this.isFieldValidated = false,
    this.validator,
    this.isPhone = false,
    this.isPasswordField = false,
    this.isForgetButton = false,
    this.keyboardType,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? isObscure : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          errorMaxLines: 2,
          filled: true,
          fillColor: AppColors.kAppBackground, // Adjust the background color
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
          suffixIcon: widget.isForgetButton
              ? CustomTextButton(
                  onPressed: () {},
                  text: 'Forgot?',
                  color: AppColors.kPrimary,
                )
              : widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.kPrimary,
                      ),
                    )
                  : Icon(widget.isPhone ? Icons.phone_android : Icons.done,
                      size: 20,
                      color: widget.isFieldValidated
                          ? AppColors.kPrimary
                          : AppColors.kLine)),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        text,
        style: TextStyle(color: color ?? AppColors.kPrimary, fontSize: 14),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.kPrimary,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.color == null ? Colors.white : Colors.black,
                fontSize: widget.fontSize ?? 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500))
      ..tween('translateY', Tween(begin: -30.0, end: 0.0),
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get('opacity'),
        child: Transform.translate(
            offset: Offset(0, animation.get('translateY')), child: child),
      ),
    );
  }
}
