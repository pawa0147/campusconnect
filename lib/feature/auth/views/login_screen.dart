import 'package:campconn/core/utils/app_colors.dart';
import 'package:campconn/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _CountryCode {
  final String name;
  final String flag;
  final String dialCode;

  const _CountryCode({
    required this.name,
    required this.flag,
    required this.dialCode,
  });
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  final List<_CountryCode> countries = const [
    _CountryCode(name: "India", flag: "🇮🇳", dialCode: "+91"),
    _CountryCode(name: "United States", flag: "🇺🇸", dialCode: "+1"),
    _CountryCode(name: "United Kingdom", flag: "🇬🇧", dialCode: "+44"),
  ];

  late _CountryCode selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = countries.first;
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.textFaintGrey,
        fontSize: 14,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  void openCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: countries.map((country) {
                return ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                  title: Text(country.name),
                  trailing: Text(
                    country.dialCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedCountry = country;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void login() {
    if (!_formKey.currentState!.validate()) return;

    final mobileNumber =
        "${selectedCountry.dialCode}${mobileController.text.trim()}";
    final password = passwordController.text.trim();

    // Later with BLoC:
    // context.read<LoginBloc>().add(
    //   LoginSubmitted(
    //     mobileNumber: mobileNumber,
    //     password: password,
    //   ),
    // );

    debugPrint("Mobile: $mobileNumber");
    debugPrint("Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.circle1,
              ),
            ),
          ),
          Positioned(
            top: -130,
            left: 5,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.circle2,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Sign in to continue your journey",
                        style: TextStyle(
                          color: AppColors.textFaintGrey,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mobile Number",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: inputDecoration(
                                hintText: "000 000 0000",
                                prefixIcon: InkWell(
                                  onTap: openCountryPicker,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(selectedCountry.flag),
                                        const SizedBox(width: 5),
                                        Text(
                                          selectedCountry.dialCode,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 18,
                                        ),
                                        Container(
                                          height: 22,
                                          width: 1,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          color: AppColors.textFaintGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                final mobile = value?.trim() ?? "";

                                if (mobile.isEmpty) {
                                  return "Please enter mobile number";
                                }

                                if (mobile.length < 10) {
                                  return "Enter a valid mobile number";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 15),

                            const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextFormField(
                              controller: passwordController,
                              obscureText: isPasswordHidden,
                              decoration: inputDecoration(
                                hintText: "********",
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.primary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordHidden
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                final password = value?.trim() ?? "";

                                if (password.isEmpty) {
                                  return "Please enter password";
                                }

                                if (password.length < 6) {
                                  return "Password must be at least 6 characters";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to forgot password screen later
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 55),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.circle2.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Privacy First",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Tap to learn how we protect you",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      PrimaryButton(
                        text: "Login",
                        onPressed: login,
                      ),

                      const SizedBox(height: 15),

                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textFaintGrey,
                          ),
                          children: [
                            TextSpan(
                              text: "By continuing, you agree to CampusConnect's ",
                            ),
                            TextSpan(
                              text: "Terms\n& Privacy Policy.",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: AppColors.textGrey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to sign up screen later
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
