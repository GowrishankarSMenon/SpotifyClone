import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/widgets/appbar/app_bar.dart';
import 'package:music_app/common/widgets/buttons/basic_app_button.dart';
import 'package:music_app/core/assets/app_vectors.dart';
import 'package:music_app/core/configs/themes/app_colors.dart';
import 'package:music_app/data/models/auth/create_user_rq.dart';
import 'package:music_app/domain/usecases/auth/signup.dart';
import 'package:music_app/presentation/auth/pages/signIn.dart';
import 'package:music_app/presentation/root/pages/root.dart';
import 'package:music_app/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signInText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50,),
            _fullNameField(context),
            const SizedBox(height: 20,),
            _emailField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 20,),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SignupUseCase>().call(
                  params: CreateUserRq(
                    fullName: _fullName.text.toString(),
                    email: _email.text.toString(),
                    password: _password.text.toString()
                  )
                );
                result.fold(
                  (l) {
                    var snackbar = SnackBar(content: Text(l, style: const TextStyle(color: Colors.black),));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  (r) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const RootPage()),
                      (route) => false
                    );
                  }
                );
              },
              title: 'Create account',
            ),
            const SizedBox(height: 20), // Add some space at the bottom
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      cursorColor: AppColors.primary,
      decoration: const InputDecoration(hintText: 'Full name').applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      cursorColor: AppColors.primary,
      decoration: const InputDecoration(hintText: 'Enter email').applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      cursorColor: AppColors.primary,
      decoration: const InputDecoration(hintText: 'Password').applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _signInText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Do you have an account?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (BuildContext context) => SignInPage() 
              )
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent; // Color when pressed
                }
                return Colors.transparent; // Default color
              },
            ),
            foregroundColor: MaterialStateProperty.all(AppColors.primary), // Text color
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            ),
          ),
          child: const Text(
            'Sign in',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    ),
  );
}

}
