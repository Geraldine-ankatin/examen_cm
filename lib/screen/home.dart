import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 173, 194),
      body:ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Image.network('https://video-public.canva.com/VAFbQhgjLjI/v/8076184ad8.gif'),
              const SizedBox(height: 20),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:const  Color.fromARGB(255, 2, 52, 94),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'proveedores');
                    },
                    child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/proveedores.png', width: 100,),
                          const SizedBox(height: 10),
                          const Text('Proveedores', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ), 
                  ),                
               )
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:const Color.fromARGB(255, 2, 52, 94),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'categorias');
                    },
                    child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/categorias.png', width: 80,),
                          const SizedBox(height: 20),
                          const Text('Categorias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ), 
                  ),                
               )
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:const Color.fromARGB(255, 2, 52, 94),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'productos');
                    },
                    child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/productos.png', width: 80,),
                          const SizedBox(height: 30),
                          const Text('Productos', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ), 
                  ),                
               )
              )
            ],
          )
        ],
      )
    );
  }
}