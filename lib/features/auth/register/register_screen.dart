import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;

  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Create an account to begin your Learning Journey",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                /// Full Name
                _buildTextField("Full Name", "Your Name Here"),

                SizedBox(height: 20.h),

                /// Email
                _buildTextField("Email", "Your Email Here"),

                SizedBox(height: 20.h),

                /// Password
                _buildPasswordField(
                  label: "Password",
                  obscure: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),

                SizedBox(height: 20.h),

                /// Confirm Password
                _buildPasswordField(
                  label: "Confirm Password",
                  obscure: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),

                SizedBox(height: 30.h),

                /// Sign Up Button
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
                      Navigator.pushNamed(context, RoutesManger.login);
                    },
                    child:  Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: ColorsManger.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),

                /// Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "Or Sign Up with",
                        style: TextStyle(color: Colors.grey.shade600),
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
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    icon: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                      height: 20.h,
                    ),
                    label: Text(
                      "Sign Up with Google",
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),

                /// Sign In
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManger.login);
                        },
                        child: Text(
                          "Sign in Here",
                          style: TextStyle(
                            color: ColorsManger.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
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

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 6.h),
        TextField(
          cursorColor: const Color.fromARGB(255, 122, 122, 122),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 198, 198, 198),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 7.w,
              vertical: 10.h,
            ),
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
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 6.h),
        TextField(
          cursorColor: const Color.fromARGB(255, 122, 122, 122),
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 7.w,
              vertical: 10.h,
            ),
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
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}
