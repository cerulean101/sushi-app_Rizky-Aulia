import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_mobile_app/models/food.dart';
import 'package:flutter/cupertino.dart';
import 'package:sushi_mobile_app/providers/cart.dart';
import 'package:sushi_mobile_app/screen/cart_screen.dart';

class DetailFood extends StatefulWidget {
  const DetailFood({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  int quantityCount = 0;
  int costPayment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(
                CupertinoIcons.cart,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                widget.food.imagePath.toString(),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.food.price} IDR',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.favorite_outline),
                    ],
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Icon(
                  //         Icons.star,
                  //         color: Colors.yellow,
                  //       );
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      SizedBox(width: 10),
                      Text(
                        '${widget.food.rating}',
                        style: TextStyle(),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                  Text(
                    '${widget.food.rating}',
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${widget.food.description}',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.brown,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: 'add',
              backgroundColor: const Color.fromARGB(109, 140, 94, 91),
              elevation: 0,
              onPressed: () {
                setState(() {
                  quantityCount++;
                  costPayment =
                      quantityCount * int.parse(widget.food.price.toString());
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
                heroTag: 'w',
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () {},
                child: Text(
                  quantityCount.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            FloatingActionButton(
              heroTag: 'rem',
              backgroundColor: const Color.fromARGB(109, 140, 94, 91),
              elevation: 0,
              onPressed: () {
                setState(() {
                  if (quantityCount > 0) {
                    quantityCount--;
                    costPayment =
                        quantityCount * int.parse(widget.food.price.toString());
                  }
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
                child: FloatingActionButton(
              heroTag: 't',
              backgroundColor: const Color.fromARGB(109, 140, 94, 91),
              elevation: 0,
              onPressed: () {
                if (quantityCount > 0) {
                  final cart = context.read<Cart>();
                  cart.addToCart(widget.food, quantityCount);
                }
                // addToCart();
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IDR $costPayment',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Add To Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
