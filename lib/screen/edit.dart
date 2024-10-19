import 'package:flutter/material.dart';
import 'package:examen_cm/services/product_service.dart';
import 'package:examen_cm/widgets/product_image.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../ui/input_decorations.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.SelectProduct!),
      child: _ProductScreenBody(
      productService: productService,
      )
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 133, 173, 194),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Producto'),
            Icon(Icons.add_shopping_cart, size: 30),
          ],
        ),
        
      ),
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.SelectProduct!.productImage,
              ),
            ],
          ),
          _ProductForm(),
        ]),
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
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.product, context);
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
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.product);
            },
            heroTag: null,
            child: const Icon(Icons.data_saver_on_sharp),
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productImage,
                onChanged: (value) => product.productImage = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'la url es obligatoria';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'url',
                  labelText: 'imagen',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'valor del producto',
                  labelText: 'Precio',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
