import 'package:flutter/material.dart';
import 'package:examen_cm/models/provider_models.dart';
import 'package:examen_cm/screen/screen.dart';
import 'package:examen_cm/services/proveedor_service.dart';
import 'package:examen_cm/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListProveedorScreen extends StatefulWidget {
  const ListProveedorScreen({super.key});

  @override
  _ListProveedorScreenState createState() => _ListProveedorScreenState();
}

class _ListProveedorScreenState extends State<ListProveedorScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
     if (proveedorService.isLoading) return const LoadingScreen();

    final filteredProveedores = proveedorService.proveedores.where((proveedor) {
      return proveedor.providerName.toLowerCase().contains(search.toLowerCase()) ||
             proveedor.providerLastName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
        title: Image.asset('assets/proveedores_titulo.png', height: 70, width: 260),
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
      body: _ProveedorList(filteredProveedores: filteredProveedores),
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
          proveedorService.selectedProveedor = ListadoProveedor(
            providerId: 0,
            providerName: '',
            providerLastName: '',
            providerMail: '',
            providerState: 'Activo',
          );
          Navigator.popAndPushNamed(context, 'editar_proveedores');
        },
      ),
    );
  }
}


class _ProveedorList extends StatelessWidget {
  final List<ListadoProveedor> filteredProveedores;

  const _ProveedorList({Key? key, required this.filteredProveedores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredProveedores.length,
      itemBuilder: (BuildContext context, index) => GestureDetector(
        onTap: () {
          final proveedorService = Provider.of<ProveedorService>(context, listen: false);
          proveedorService.selectedProveedor = filteredProveedores[index].copy();
          Navigator.pushNamed(context, 'editar_proveedores');
        },
        child: ProveedorCard(proveedor: filteredProveedores[index]),
      ),
    );
  }
}
