import 'package:flutter/material.dart';
import 'package:examen_cm/models/categorias.dart'; 
import 'package:examen_cm/screen/loading.dart';
import 'package:examen_cm/services/categorias_service.dart'; 
import 'package:examen_cm/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListCategoriaScreen extends StatefulWidget {
  const ListCategoriaScreen({super.key});

  @override
  _ListCategoriaScreenState createState() => _ListCategoriaScreenState();
}

class _ListCategoriaScreenState extends State<ListCategoriaScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final categoriaService = Provider.of<CategoriaService>(context);

   if (categoriaService.isLoading) return const LoadingScreen();

    final filteredCategories = categoriaService.categorias.where((categoria) {
      return categoria.categoryName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
        title: Image.asset('assets/categorias_titulo.png', height: 70, width: 260),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Buscar productos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            )),

      ),
      body: _CategoriaList(filteredCategories: filteredCategories),
      floatingActionButton: FloatingActionButton(
        shape:  RoundedRectangleBorder(
           side:const BorderSide(
            color: Colors.white,
            width: 4.0,  
            ),
             borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor:const Color.fromARGB(255, 2, 52, 94),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          categoriaService.selectedCategoria = ListadoCategoria( 
            categoryId: 0,
            categoryName: '',
            categoryState: 'Activa',
          );
          Navigator.popAndPushNamed(context, 'editar_categorias'); 
        },
      ),
    );
  }
}

class _CategoriaList extends StatelessWidget {
  final List<ListadoCategoria> filteredCategories;

  const _CategoriaList({Key? key, required this.filteredCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredCategories.length,
      itemBuilder: (BuildContext context, index) => GestureDetector(
        onTap: () {
          final categoriaService = Provider.of<CategoriaService>(context, listen: false);
          categoriaService.selectedCategoria = filteredCategories[index].copy(); 
          Navigator.pushNamed(context, 'editar_categorias'); 
        },
        child: CategoriaCard(categoria: filteredCategories[index]), 
      ),
    );
  }
}
