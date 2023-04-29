import 'package:fake_store/router/app_router.dart';
import 'package:fake_store/views/auth/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helper/theme_changer.dart';
import '../../router/export.dart';
import '../../utils/toast.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  FocusNode myfocus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(authProvider);
    Future.delayed(const Duration(seconds: 0), () {
      myfocus.requestFocus(); //auto focus on second text field.
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool theme = ref.watch(themeProvider).isDark;
    final auth = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              bottom: theme ? -1000 : 80,
              right: theme ? -1000 : 35,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.linear,
                  width: theme ? (MediaQuery.of(context).size.height * 3) : 0,
                  height: theme ? (MediaQuery.of(context).size.height * 3) : 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height),
                    color: Colors.blueGrey[900],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/images/avater.jpg',
                        // color: Colors.green[300],
                      ),
                    ),
                    Container(height: 15),
                    TextField(
                      controller: _email,
                      //Next Go
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      // style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.blueGrey[400]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[400]!, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[400]!, width: 2),
                        ),
                      ),
                    ),
                    Container(height: 25),
                    TextField(
                      controller: _pass,
                      // focusNode: myfocus,
                      //Or as done here
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      // style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.blueGrey[400]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[400]!, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[400]!, width: 2),
                        ),
                      ),
                    ),
                    Container(height: 5),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.transparent,
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blueGrey[400]),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: !auth.isLoading
                            ? const Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              )
                            : const CupertinoActivityIndicator(),
                        onPressed: () {
                          if (_email.text.isEmpty || _pass.text.isEmpty) {
                            showToastMessage('Email or Password Empty');
                          } else if (!_email.text.contains('@')) {
                            showToastMessage('Invalid Email');
                          } else {
                            ref.read(authProvider).login(_email.text, _pass.text);
                            if (auth.token.isNotEmpty && auth.isLoading) {
                              showToastMessage('Login:${auth.token}');
                              goTo(context, home);
                            } else if (auth.token.isEmpty && auth.isLoading) {
                              showToastMessage('Login Failed');
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.transparent),
                        child: Text(
                          "Eye Protection? Switch Theme",
                          style: TextStyle(color: Colors.green[300]),
                        ),
                        onPressed: () {
                          ref.read(themeProvider).switchTheme();
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
