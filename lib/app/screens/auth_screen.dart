import 'package:flutter/material.dart';
import 'package:mockcrack/app/screens/home_screen.dart';
import 'package:mockcrack/app/widgets/auth_tile_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // ignore: avoid_print
      print(
          'Account created with: {${_usernameController.text}, ${_fullNameController.text}, ${_emailController.text}, ${_designationController.text} , ${_passwordController.text}}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // logo
                Image.asset('assets/images/splash.png'),

                // forms
                Column(
                  children: [
                    authTile(
                      label: "Username",
                      hintText: "eg. Jhon06",
                      icon: Icons.person,
                      ctx: context,
                      controller: _usernameController,
                    ),
                    authTile(
                      label: "Full Name",
                      hintText: "eg. Jhon Doe",
                      icon: Icons.person_outline,
                      ctx: context,
                      controller: _fullNameController,
                    ),
                    authTile(
                      label: "Email",
                      hintText: "eg. Jhon@example.com",
                      icon: Icons.email,
                      ctx: context,
                      controller: _emailController,
                    ),
                    authTile(
                      label: "Designation",
                      hintText: "eg. Software Engineer",
                      icon: Icons.work,
                      ctx: context,
                      controller: _designationController,
                    ),
                    Container(
                      height: mq.height * 0.07,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: mq.height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffc2c2c2),
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Icon(
                              Icons.password,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text("Password"),
                                hintText: "eg. Pass123",
                              ),
                              style: const TextStyle(color: Colors.black),
                              controller: _passwordController,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Icon(
                              Icons.visibility_off,
                              color: Colors.green,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mq.height * 0.03),
                // button

                Container(
                  height: mq.height * 0.07,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: mq.height * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: _submitForm,
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
