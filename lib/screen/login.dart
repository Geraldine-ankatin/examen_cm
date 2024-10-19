import 'package:flutter/material.dart';
import 'package:examen_cm/providers/login_form_providers.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Wrap(
        children: [
          Center(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                const SizedBox(height: 40),
                ChangeNotifierProvider(
                  create: (_)=> LoginFormProvider(),
                  child:const LoginForm(),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed:(){
                    Navigator.pushNamed(context, 'registro');
                  },
                  child:const Text('¿No tienes una cuenta? Registrate',style: TextStyle(color: Colors.blueGrey),) ,
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      )
      
      
    );
  }
}