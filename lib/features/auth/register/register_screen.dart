import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey             = GlobalKey<FormState>();
  final _usernameCtrl        = TextEditingController();
  final _emailCtrl           = TextEditingController();
  final _passwordCtrl        = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool  _obscurePassword        = true;
  bool  _obscureConfirmPassword = true;
  bool  _submitted              = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _signUp() {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushNamed(context, RoutesManger.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // ── Title ──────────────────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Text(l10n.signup,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 6.h),
                        Text(
                          'Create an account to begin your Learning Journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // ── Username ────────────────────────────────────────────
                  _FieldLabel(label: l10n.username),
                  _ValidatedField(
                    controller: _usernameCtrl,
                    hint: l10n.username,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? '${l10n.username} is required'
                        : null,
                  ),
                  SizedBox(height: 16.h),

                  // ── Email ───────────────────────────────────────────────
                  _FieldLabel(label: l10n.email),
                  _ValidatedField(
                    controller: _emailCtrl,
                    hint: 'example@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return '${l10n.email} is required';
                      }
                      final emailRegex =
                          RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$');
                      if (!emailRegex.hasMatch(v.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // ── Password ────────────────────────────────────────────
                  _FieldLabel(label: l10n.password),
                  _ValidatedField(
                    controller: _passwordCtrl,
                    hint: l10n.password,
                    obscure: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return '${l10n.password} is required';
                      }
                      if (v.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // ── Confirm Password ────────────────────────────────────
                  _FieldLabel(label: l10n.confirmpassword),
                  _ValidatedField(
                    controller: _confirmPasswordCtrl,
                    hint: l10n.confirmpassword,
                    obscure: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return '${l10n.confirmpassword} is required';
                      }
                      if (v != _passwordCtrl.text) {
                        return 'Passwords do not match'; // ← mismatch alert
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),

                  // ── Sign Up button ──────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      onPressed: _signUp,
                      child: Text(l10n.signup.toUpperCase(),
                          style: TextStyle(
                            color: ColorsManger.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.sp,
                          )),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // ── Divider ─────────────────────────────────────────────
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(l10n.orsigninwith,
                            style: TextStyle(color: Colors.grey.shade600)),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ── Google button ───────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      onPressed: () {},
                      icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/300/300221.png',
                          height: 20.h),
                      label: Text(l10n.signupwithgoogle,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).primaryColorLight)),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // ── Sign in link ────────────────────────────────────────
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color:
                                    Theme.of(context).primaryColorLight)),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RoutesManger.login),
                          child: Text(l10n.signin,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Field label ───────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(label,
            style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColorLight)),
      );
}

// ── Reusable validated text field ─────────────────────────────────────────────
class _ValidatedField extends StatelessWidget {
  const _ValidatedField({
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscure = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final String? Function(String?) validator;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      cursorColor: const Color.fromARGB(255, 122, 122, 122),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 198, 198, 198),
            fontSize: 12.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(fontSize: 11.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 198, 198, 198), width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 122, 122, 122), width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              BorderSide(color: Colors.red.shade400, width: 1.5.w),
        ),
      ),
    );
  }
}
