import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                /// Back Button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),

                SizedBox(height: 10.h),

                /// Title
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Sign in",
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorsManger.black,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Please Sign in with your account",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                /// Email
                const Text("Email"),
                SizedBox(height: 6.h),
                _buildTextField(),

                SizedBox(height: 20.h),

                /// Password
                const Text("Password"),
                SizedBox(height: 6.h),
                _buildPasswordField(),

                SizedBox(height: 10.h),

                /// Forgot Password
                SizedBox(height: 20.h),

                /// Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManger.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesManger.mainLayout);
                    },
                    child: Text(
                      "SIGN IN",
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorsManger.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                /// Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "Or Sign in with",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: 20.h),

                /// Google Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    icon: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                      height: 20.h,
                    ),
                    label: Text(
                      "Sign In with Google",
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),

                /// Sign Up
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManger.register);
                        },
                        child: Text(
                          "Sign up Here",
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 17.sp,
                          ),
                        ),
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

  Widget _buildTextField() {
    return TextField(
      cursorColor: const Color.fromARGB(255, 122, 122, 122),
      decoration: InputDecoration(
        hint: Text(
          'example@email.com',
          style: TextStyle(
            color: Color.fromARGB(255, 198, 198, 198),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        filled: true,
        fillColor: ColorsManger.white,

        contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 198, 198, 198),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 122, 122, 122),
            width: 1.w,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: _obscurePassword,
      cursorColor: const Color.fromARGB(255, 122, 122, 122),
      decoration: InputDecoration(
        hint: Text(
          'Password',
          style: TextStyle(
            color: Color.fromARGB(255, 198, 198, 198),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),

        filled: true,
        fillColor: ColorsManger.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 198, 198, 198),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 122, 122, 122),
            width: 1.w,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }
}
