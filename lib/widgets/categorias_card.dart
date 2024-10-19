import 'package:flutter/material.dart';
import 'package:examen_cm/models/categorias.dart'; 

class CategoriaCard extends StatelessWidget { 
  final ListadoCategoria categoria;

  const CategoriaCard({Key? key, required this.categoria}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:const  Color.fromARGB(255, 2, 52, 94),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Card(
            color: Colors.white,
            child:ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text('Nombre: ${categoria.categoryName}'), 
                      Text('ID: ${categoria.categoryId}'), 
                      Text('Estado: ${_handleCategoriaState(categoria.categoryState)}',
                        style:const TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                  const Icon(Icons.edit,size: 30,),
            
                ],
              ),
            ),

          )
        )
      ),
      const SizedBox(height: 20)
    ], 
  );
}
  
  String _handleCategoriaState(String state) {
    return state; 
  }
}