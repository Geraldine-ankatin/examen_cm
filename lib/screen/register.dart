import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_cm/providers/login_form_providers.dart';
import 'package:examen_cm/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body:  Wrap(
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
                const Text('Crea una cuenta', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                const SizedBox(height: 40),
                ChangeNotifierProvider(
                  create: (_)=> LoginFormProvider(),
                  child:const RegisterForm(),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed:(){
                    Navigator.pushNamed(context, 'login');
                  },
                  child:const Text('¿Ya tienes una cuenta? Ingresa aquí',style: TextStyle(color: Colors.blueGrey),) ,
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