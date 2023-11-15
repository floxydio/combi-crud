import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sqlitetodo/constant/sizing.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';

class SignInAuth extends StatefulWidget {
  const SignInAuth({super.key});

  @override
  State<SignInAuth> createState() => _SignInAuthState();
}

class _SignInAuthState extends State<SignInAuth> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: "Username", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: Sizing.paddingInput,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      child: isPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                  hintText: "Password",
                  border: const OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: "Dont have an account?",
                    style: const TextStyle(color: Colors.black),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: " Sign Up",
                      style: const TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold))
                ])),
            SizedBox(
              height: Sizing.paddingButton,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    if (usernameController.text == "admin" &&
                        passwordController.text == "123") {
                      SharedPrefs.setToken("token", "eyJ111").then((value) => {
                            if (value)
                              {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomePageNoVM()))
                              }
                            else
                              print("Gagal Save")
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                                  content: Center(
                                child: Text("Username atau password salah"),
                              )));
                    }
                  },
                  child: const Text("Sign In")),
            )
          ],
        ),
      )),
    ));
  }
}
