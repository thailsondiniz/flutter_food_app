import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/data/categorias.dart';
import 'package:flutter_food_app/data/pizzasMenu.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> dados = [];
  void categoria() async {
    Uri url = Uri.parse('http://10.0.2.2:3000/categorias');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dados = jsonDecode(response.body);
        print(dados);
      });
    }
  }

  List<dynamic> dadosPizza = [];
  void pizza() async {
    Uri url = Uri.parse('http://10.0.2.2:3000/pizzasMenu');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dadosPizza = jsonDecode(response.body);
        print(dadosPizza);
      });
    }
  }

  List<CartItem> cartItems = [];

  void addToCart(PizzasMenu pizza) {
    setState(() {
      // Usa firstWhereOrNull que é uma extensão do pacote collection
      final existingItem =
          cartItems.firstWhereOrNull((item) => item.pizza.id == pizza.id);

      if (existingItem != null) {
        // Se já estiver no carrinho, apenas aumenta a quantidade
        existingItem.increment();
      } else {
        // Se não estiver no carrinho, adiciona um novo item
        cartItems.add(CartItem(pizza: pizza));
      }
    });
  }

  double get cartTotal =>
      cartItems.fold(0, (total, current) => total + current.totalPrice);

  int get totalItems =>
      cartItems.fold(0, (total, current) => total + current.quantity);

  void removeFromCart(PizzasMenu pizza) {
    setState(() {
      final existingItem =
          cartItems.firstWhereOrNull((item) => item.pizza.id == pizza.id);

      if (existingItem != null && existingItem.quantity > 1) {
        existingItem.decrement();
      } else {
        cartItems.remove(existingItem);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // categorias();
    categoria();
    pizza();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10),
              child: Text(
                'Perfil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color(0xffCC092F),
              ),
              title: const Text(
                'Perfil',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.payment,
                color: Color(0xffCC092F),
              ),
              title: const Text(
                'Cartões',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10),
              child: Text(
                'Mais Serviços',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xffCC092F),
              ),
              title: const Text(
                'Agendamentos',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.co_present_rounded,
                color: Color(0xffCC092F),
              ),
              title: const Text(
                'Atualização Cadastral',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.storefront,
                color: Color(0xffCC092F),
              ),
              title: const Text(
                'Autorização de Parceiros',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xfff5f5f5),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              size: 30,
              color: Color(0xff2b2626),
            ),
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Container(
                      width: 25,
                      height: 20,
                      decoration: BoxDecoration(
                          color: const Color(0xffeb3254),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '$totalItems',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Color(0xFFD0D0D0),
                  //       spreadRadius: 1,
                  //       blurRadius: 3)
                  // ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Order again?',
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2b2626)),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Hot Salami Pizza, Cole Slow, Pepsi',
                          style:
                              TextStyle(color: Color(0xFFC7C7C7), fontSize: 17),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xffeb3254),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 28,
                              color: Color(0xffeb3254),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              height: 140,
              // decoration: const BoxDecoration(color: Colors.red),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  // final categoria = categoriasList[index];
                  final Categoria item = Categoria.fromJson(dados[index]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 125,
                      decoration: BoxDecoration(
                        // boxShadow: const [
                        //   BoxShadow(
                        //       color: Color(0xFFD0D0D0),
                        //       spreadRadius: 1,
                        //       blurRadius: 3)
                        // ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            item.foto,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            item.nome,
                            style: const TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: dadosPizza.length,
                itemBuilder: (context, index) {
                  final PizzasMenu itemPizza =
                      PizzasMenu.fromJson(dadosPizza[index]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 125,
                      height: 170,
                      child: Row(
                        children: [
                          Image.network(
                            itemPizza.foto,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemPizza.nome,
                                style: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                itemPizza.tamanho,
                                style: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 16.0,
                                    color: Color(0xFFC7C7C7),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 4,
                                          bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xffeb3254),
                                      ),
                                      child: Text(
                                        itemPizza.preco.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 13.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              removeFromCart(itemPizza),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color(0xffeb3254),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Color(0xffeb3254),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () => addToCart(itemPizza),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color(0xffeb3254),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Color(0xffeb3254),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '\$${cartTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 25.0,
                            color: Color(0xffeb3254),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '$totalItems items',
                        style: const TextStyle(
                            color: Color(0xFFC7C7C7), fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 75, right: 75, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffeb3254),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final PizzasMenu pizza;
  int quantity;

  CartItem({required this.pizza, this.quantity = 1});

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 0) {
      quantity--;
    }
  }

  double get totalPrice => pizza.preco * quantity;
}
