import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/userAuth.dart';
import 'package:wikidados_teste/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isVisible = true, isLoading = true;
  String errorMsg = "";

  void initState() {
    super.initState();

    checkIsLogged();
  }

  Future checkIsLogged() async {
    bool isLogged =
        await Provider.of<UserAuth>(context, listen: false).isLogged();

    if (isLogged) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void handleLogin() {
    bool res = Provider.of<UserAuth>(context, listen: false)
        .login(_emailController.text, _passwordController.text);

    // Sucessful login
    if (res) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      setState(
        () {
          errorMsg = "Login falhou";
        },
      );

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          errorMsg = "";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // Email Text Field
            TextField(
              controller: _emailController,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),

            // Padding
            SizedBox(
              height: 15,
            ),

            // Password Text Field
            TextField(
              controller: _passwordController,
              obscureText: isVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  )),
            ),

            // Padding
            Container(
              height: 20,
              child: Text(
                errorMsg,
                style: TextStyle(color: Colors.red),
              ),
            ),

            // Submit Button
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: handleLogin,
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Entrar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
