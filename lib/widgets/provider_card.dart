import 'package:flutter/material.dart';
import 'package:examen_cm/models/provider_models.dart'; 

class ProveedorCard extends StatelessWidget {
  final ListadoProveedor proveedor; 

  const ProveedorCard({Key? key, required this.proveedor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Column(
                      children: [
                        Text('Correo: ${proveedor.providerMail}'), 
                        Text('ID: ${proveedor.providerId}'),
                        Text('Estado: ${_handleProveedorState(proveedor.providerState)}',
                          style:const TextStyle(
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        const Icon(Icons.edit,size: 30,),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

        ),
        const SizedBox(height: 20)
      ],
    );
    
    
  }

  String _handleProveedorState(String state) {
    return state;
  }
}