import 'package:flutter/material.dart';
import 'package:examen_cm/services/proveedor_service.dart';
import 'package:provider/provider.dart';
import '../providers/proveedores_form.dart';
import 'package:examen_cm/ui/input_decorations.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProveedorFormProvider(proveedorService.selectedProveedor!),
      child: _ProveedorScreenBody(
        proveedorService: proveedorService,
      ),
    );
  }
}

class _ProveedorScreenBody extends StatelessWidget {
  const _ProveedorScreenBody({
    Key? key,
    required this.proveedorService,
  }) : super(key: key);

  final ProveedorService proveedorService;

  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
       appBar: AppBar(
        title: const Text('Proveedores'),
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
       ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _ProveedorForm(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            shape:  RoundedRectangleBorder(
           side:const BorderSide(
            color: Color.fromARGB(255, 2, 52, 94),
            width: 4.0,  
            ),
             borderRadius: BorderRadius.circular(20.0),
        ),
            
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              bool success = await proveedorService.deleteProveedor(proveedorForm.proveedor, context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proveedor eliminado con éxito.')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed('proveedores'); 
                });
              }
            },
            heroTag: null,
            child: const Icon(Icons.delete_forever),
          ),
          const SizedBox(width: 20),

          FloatingActionButton(
            shape:  RoundedRectangleBorder(
           side:const BorderSide(
            color: Color.fromARGB(255, 2, 52, 94),
            width: 4.0,  
            ),
             borderRadius: BorderRadius.circular(20.0),
            ),
            
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.editOrCreateProveedor(proveedorForm.proveedor);              
              await proveedorService.loadProveedores();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proveedor guardado con éxito.')),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed('proveedores'); 
              });
            },
            heroTag: null,
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}

class _ProveedorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    final proveedor = proveedorForm.proveedor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: proveedorForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerId.toString(), 
                readOnly: true, 
                decoration:const InputDecoration(
                  hintText: 'ID del proveedor',
                  labelText: 'ID:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerName,
                onChanged: (value) => proveedor.providerName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Nombre del proveedor',
                  hintStyle:TextStyle(color:Colors.grey),
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerLastName,
                onChanged: (value) => proveedor.providerLastName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El apellido es obligatorio';
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: 'Apellido del proveedor',
                  hintStyle:TextStyle(color:Colors.grey),
                  labelText: 'Apellido:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerMail,
                onChanged: (value) => proveedor.providerMail = value,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Correo electrónico inválido';
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: 'Correo electrónico',
                  hintStyle:TextStyle(color:Colors.grey),
                  labelText: 'Correo:',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: proveedor.providerState,
                items: const [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                ],
                onChanged: (value) {
                  proveedor.providerState = value ?? 'Inactivo';
                },
                decoration:const InputDecoration(
                  labelText: 'Estado del Proveedor:',
                  hintText: 'Selecciona el estado',
                  hintStyle:TextStyle(color:Colors.grey),
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
