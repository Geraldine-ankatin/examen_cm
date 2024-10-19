import 'package:flutter/material.dart';
import 'package:examen_cm/services/categorias_service.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class EditCategoriaScreen extends StatelessWidget {
  const EditCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriasService = Provider.of<CategoriaService>(context);
    return ChangeNotifierProvider(
      create: (_) => CategoriaFormProvider(categoriasService.selectedCategoria!), 
      child: _CategoriaScreenBody(
        categoriasService: categoriasService,
      ),
    );
  }
}

class _CategoriaScreenBody extends StatelessWidget {
  const _CategoriaScreenBody({
    Key? key,
    required this.categoriasService,
  }) : super(key: key);

  final CategoriaService categoriasService;

  @override
  Widget build(BuildContext context) {
    final categoriaForm = Provider.of<CategoriaFormProvider>(context);
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 133, 173, 194),
       appBar: AppBar(
        title: const Text('Categoria'),
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
       ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            const SizedBox(height: 20),
            _CategoriaForm(),
          ],
        )
        
          
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
              if (!categoriaForm.isValidForm()) return;
              bool success = await categoriasService.deleteCategoria(categoriaForm.categoria, context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Categoría eliminada con éxito.')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed('categorias'); 
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
              if (!categoriaForm.isValidForm()) return;             
              await categoriasService.editOrCreateCategoria(categoriaForm.categoria);             
              await categoriasService.loadCategorias(); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Categoría guardada con éxito.')),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed('categorias'); 
              });
            },
            heroTag: null,
            child: const Icon(Icons.data_saver_on_sharp),
          ),
        ],
      ),
    );
  }
}

class _CategoriaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriaForm = Provider.of<CategoriaFormProvider>(context);
    final categoria = categoriaForm.categoria;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoriaForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: categoria.categoryName,
                onChanged: (value) => categoria.categoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration:const  InputDecoration(
                  hintText: 'Nombre de la categoría',
                  hintStyle:TextStyle(color:Colors.grey),
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: categoria.categoryState,
                items: const [
                  DropdownMenuItem(value: 'Activa', child: Text('Activa')),
                  DropdownMenuItem(value: 'Inactiva', child: Text('Inactiva')),
                ],
                onChanged: (value) {
                  categoria.categoryState = value ?? 'Inactiva';
                },
                decoration:const InputDecoration(
                  labelText: 'Estado :',
                  hintStyle:TextStyle(color:Colors.grey),
                  hintText: 'Selecciona el estado',
                ),
              ),
              const SizedBox(height: 40),
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

