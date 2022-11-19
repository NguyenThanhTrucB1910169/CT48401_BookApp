import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../card/cart_manager.dart';
import '../../models/http_exception.dart';
import '../shared/screens.dart';
// import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in

        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      // showErrorDialog(
      //     context,
      //     (error is HttpException)
      //         ? error.toString()
      //         : 'Authentication failed');
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 60),
        child: Text('${_authMode == AuthMode.login ? 'Login' : 'Signup'}',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            )
            // TextStyle(
            //   color: Colors.white,
            //   fontSize: 50,
            //   fontFamily: GoogleFonts.playfairDisplay()
            //   fontWeight: FontWeight.bold,
            // ),
            ),
      ),
      // Card(
      //   // shape: RoundedRectangleBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(30))),
      //   // color: Colors.white.withOpacity(0.5),
      //   child: Container(
      //     height: _authMode == AuthMode.signup ? 320 : 260,
      //     // constraints:
      //     // BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
      //     // width: deviceSize.width,
      //     padding: const EdgeInsets.all(16.0),
      //     child:
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildEmailField(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: _buildPasswordField(),
              ),
              if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isSubmitting,
                builder: (context, isSubmitting, child) {
                  if (isSubmitting) {
                    return const CircularProgressIndicator();
                  }
                  return _buildSubmitButton();
                },
              ),
              _buildAuthModeSwitchButton(),
            ],
          ),
        ),
      ),
    ]);
    //   )
    // ]
    // );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: TextStyle(
          color: Colors.teal,
        ),
      ),
      child: Text(
        '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
        style: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
                width: 2, color: Color.fromARGB(255, 134, 149, 147))),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 127.0, vertical: 15.0),
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      child: Text(
        _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
        style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'Playfair Display'),
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        enabled: _authMode == AuthMode.signup,
        decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            filled: true,
            fillColor: Colors.white,
            // focusColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 134, 149, 147)),
                borderRadius: BorderRadius.circular(50.0))),
        obscureText: true,
        validator: _authMode == AuthMode.signup
            ? (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match!';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            filled: true,
            fillColor: Colors.white,
            // focusColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 134, 149, 147)),
                borderRadius: BorderRadius.circular(50.0))),
        obscureText: true,
        controller: _passwordController,
        validator: (value) {
          if (value == null || value.length < 5) {
            return 'Password is too short!';
          }
          return null;
        },
        onSaved: (value) {
          _authData['password'] = value!;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        // style: TextStyle(fontSize: 20.0, color: Colors.black),
        decoration: InputDecoration(
            labelText: 'E-Mail',
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            prefixIcon: Icon(Icons.person),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            filled: true,
            fillColor: Colors.white,
            // focusColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 176, 207, 204)),
                borderRadius: BorderRadius.circular(50.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 134, 149, 147)),
                borderRadius: BorderRadius.circular(50.0))),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty || !value.contains('@')) {
            return 'Invalid email!';
          }
          return null;
        },
        onSaved: (value) {
          _authData['email'] = value!;
        },
      ),
    );
  }
}
