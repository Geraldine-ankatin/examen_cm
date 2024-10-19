import 'package:flutter/material.dart';
import 'package:examen_cm/models/products.dart';
import 'package:examen_cm/services/product_service.dart';
import 'package:examen_cm/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:examen_cm/screen/loading.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});
  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();
    final filteredProducts = productService.products.where((product) {
      return product.productName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
        title:Image.asset('assets/productos_titulo.png', height: 70, width: 260), 
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
      body:_ListaProductos(filteredProducts: filteredProducts),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color.fromARGB(255, 2, 52, 94),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage:
                'https://media-public.canva.com/2JNgQ/MAF4zW2JNgQ/1/tl.png',
            productState: '',
          );
          Navigator.popAndPushNamed(context, 'edit');
        },
      ),
    );
  }
}

class _ListaProductos extends StatelessWidget{
  final List<Listado> filteredProducts;
  const _ListaProductos({Key? key, required this.filteredProducts}): super (key:key);

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (BuildContext context, index)=> GestureDetector(
        onTap: (){
          final productService = Provider.of<ProductService>(context, listen: false);
          productService.SelectProduct = filteredProducts[index].copy();
          Navigator.pushNamed(context,'edit');
        },
        child: ProductCard(product: filteredProducts[index]),
      )
    );
  }
}
