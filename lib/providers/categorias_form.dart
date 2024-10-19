import 'package:flutter/material.dart';
import 'package:examen_cm/models/categorias.dart'; 
class CategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ListadoCategoria categoria; 

  CategoriaFormProvider(this.categoria);

  
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false; 
  }
}