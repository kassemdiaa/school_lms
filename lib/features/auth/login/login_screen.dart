import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/features/auth/widgets/validated_field.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey              = GlobalKey<FormState>();
  final _usernameCtrl         = TextEditingController();
  final _passwordCtrl         = TextEditingController();
  bool  _obscurePassword      = true;
  bool  _submitted            = false; // show errors only after first submit

  static const _kUsername = 'logged_username';

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUsername, _usernameCtrl.text.trim());
    if (mounted) Navigator.pushNamed(context, RoutesManger.mainLayout);
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
                        Text(l10n.signin,
                            style: GoogleFonts.plusJakartaSans(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w900,
                            )),
                        SizedBox(height: 6.h),
                        Text(l10n.pleasesignin,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14.sp)),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // ── Username ────────────────────────────────────────────
                  Text(l10n.username,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight)),
                  SizedBox(height: 6.h),
                  ValidatedField(
                    controller: _usernameCtrl,
                    hint: l10n.username,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? '${l10n.username} is required'
                        : null,
                  ),
                  SizedBox(height: 20.h),

                  // ── Password ────────────────────────────────────────────
                  Text(l10n.password,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight)),
                  SizedBox(height: 6.h),
                  ValidatedField(
                    controller: _passwordCtrl,
                    hint: l10n.password,
                    obscure: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? '${l10n.password} is required'
                        : null,
                  ),
                  SizedBox(height: 24.h),

                  // ── Sign In button ──────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      onPressed: _signIn,
                      child: Text(l10n.signin.toUpperCase(),
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // ── Divider ─────────────────────────────────────────────
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(l10n.orsigninwith,
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.grey.shade600)),
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
                            borderRadius: BorderRadius.circular(10.r)),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      onPressed: () {},
                      icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/300/300221.png',
                          height: 20.h),
                      label: Text(l10n.signinwithgoogle,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).primaryColorLight)),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // ── Sign up link ────────────────────────────────────────
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${l10n.didnthaveaccount} ',
                            style: TextStyle(
                                color:
                                    Theme.of(context).primaryColorLight)),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RoutesManger.register),
                          child: Text(l10n.signuphere,
                              style: GoogleFonts.plusJakartaSans(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 17.sp,
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

// ── Reusable validated text field ─────────────────────────────────────────────
