import 'package:chat/componens/my_button.dart';
import 'package:chat/componens/my_text_field.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPages extends StatefulWidget {
  final void Function()? onTap;
  const LoginPages({super.key,
    required this.onTap,
  });

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn () async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 50),

                const Text(
                  "Welcome back you have been missed!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                MyTextField(mycontroller: emailController, hintText: 'Email', obscureText: false,),
                const SizedBox(height: 25),

                MyTextField(mycontroller: passwordController, hintText: 'Password', obscureText: false,),
                const SizedBox(height: 25),

                MyButton(onTap: signIn, text: 'Sign In'),
                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                        child: const Text('Register Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
