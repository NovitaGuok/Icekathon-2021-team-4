import 'package:flutter/material.dart';
import 'package:frontend/components/tab_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/second.dart';
import 'package:frontend/globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => LoginScreenState();
}

class User {
  final String username;
  final String password;

  User(this.username, this.password);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  bool _isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: _isVisible ? false : true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => updateStatus(),
                        icon: Icon(_isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor
                      ),
                      child: const Text('LOGIN'),
                      onPressed: () {
                        login();
                      },
                    )),
              ],
            )));
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      String url = "${globals.baseUrl}/auth";
      User user = User(emailController.text, passwordController.text);
      final response = await http.post(Uri.parse(url), headers: {
        "Accept": "*/*",
        "Content-Type": "application/json"
      }, body: jsonEncode({
        "username": "novita@icehousecorp.com",
        "password": "password"
      }));
      if (response.statusCode == 200) {
        globals.token = jsonDecode(response.body)['data']['token']['access_token'];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const BottomTabBar()));
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Yeayyy.")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid credentials.")));
      }
      print(response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blank field not allowed!")));
    }
  }
}

//
// onPressed: () async {
// await Navigator.push(context,
// MaterialPageRoute(builder: (context) => const LoginScreen()));
// },
