import 'package:flutter/material.dart';
import '../screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'home';
  static Map<String, Widget Function(BuildContext)> routes={
    'home':(BuildContext context)=> const HomeScreen(),
    'login': (BuildContext context)=> const LoginScreen(),
    'proveedores': (BuildContext context)=> const ListProveedorScreen(),
    'productos': (BuildContext context)=> const ListProductScreen(),
    'categorias': (BuildContext context)=> const ListCategoriaScreen(),
    'registro': (BuildContext context)=> const RegisterScreen(),
    'edit':(BuildContext context)=> const EditProductScreen(),
    'editar_proveedores':(BuildContext context)=> const EditProveedorScreen(),
    'editar_categorias':(BuildContext context)=> const EditCategoriaScreen(),
    
  };
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context)=> const ErrorScreen(),
      );
  }
}