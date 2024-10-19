import 'package:flutter/material.dart';
import '../ui/input_decorations.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:examen_cm/providers/login_form_providers.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: LoginForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecortions.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecortions.authInputDecoration(
              hinText: 'Ingrese su contraseña',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: LoginForm.isLoading ? null
              : () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    LoginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                        LoginForm.email, LoginForm.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario o contraseña incorrecta'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    LoginForm.isLoading = false;
                  },
            
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const  Color.fromARGB(255, 2, 52, 94),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal:50, vertical: 10),
            ),
            child:const Text('Ingresar', style: TextStyle(fontSize: 16),),

          )
          ]
        ),
      ),
    );
  }
}
