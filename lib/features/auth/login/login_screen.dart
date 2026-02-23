import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                
                SizedBox(height: 10.h),
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
                Text(l10n.email,style: TextStyle(color: Theme.of(context).primaryColorLight),),
                SizedBox(height: 6.h),
                _buildTextField('example@email.com'),
                SizedBox(height: 20.h),
                Text(l10n.password,style: TextStyle(color: Theme.of(context).primaryColorLight),),
                SizedBox(height: 6.h),
                _buildPasswordField(l10n),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, RoutesManger.mainLayout),
                    child: Text(l10n.signin.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorsManger.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                SizedBox(height: 30.h),
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
                            fontSize: 15.sp, color: Theme.of(context).primaryColorLight)),
                  ),
                ),
                SizedBox(height: 25.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${l10n.didnthaveaccount} ',style: TextStyle(color: Theme.of(context).primaryColorLight),),
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
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      cursorColor: const Color.fromARGB(255, 122, 122, 122),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 198, 198, 198),
            fontSize: 12.sp),
        filled: true,
        fillColor: ColorsManger.white,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
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
      ),
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return TextField(
      obscureText: _obscurePassword,
      cursorColor: const Color.fromARGB(255, 122, 122, 122),
      decoration: InputDecoration(
        hintText: l10n.password,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 198, 198, 198),
            fontSize: 12.sp),
        filled: true,
        fillColor: ColorsManger.white,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
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
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
    );
  }
}
