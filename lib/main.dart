import 'package:flutter/material.dart';
import 'package:examen_cm/routes/app_routes.dart';
import 'package:examen_cm/services/product_service.dart';
import 'package:examen_cm/services/proveedor_service.dart';
import 'package:examen_cm/services/categorias_service.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';


void main(){
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => ProveedorService()),
        ChangeNotifierProvider(create: (_) => CategoriaService()), 
      ],
      child: const MainApp(),
    );
  }
}


class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen Geraldine Cares',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
  
    );
  }
}