import 'dart:convert';
import 'dart:ui';
import 'package:sushi_mobile_app/models/food.dart';
import 'package:sushi_mobile_app/screen/detail_food.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String accountNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> food = [];

  Future<void> loadFoodData() async {
    String jsonData = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = json.decode(jsonData);
    setState(() {
      food = jsonMap.map((json) => Food.fromJson(json)).toList();
    });
    debugPrint(food[0].imagePath.toString());
  }

  @override
  void initState() {
    loadFoodData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sushiman',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 15,
                ),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.cart,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 200,
              padding: EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sushi_nigiri.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    )),
              ),
              child: Stack(
                children: [
                  Text(
                    'Get 78% Promo\nSushi Nigiri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: CupertinoButton(
                      color: Colors.red.withOpacity(0.5),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Redeem'),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Searchbar
          SearchBar(
            hintText: 'Search Food',
            hintStyle: MaterialStatePropertyAll(
              TextStyle(
                color: Colors.grey,
              ),
            ),
            leading: Icon(CupertinoIcons.search),
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            elevation: MaterialStatePropertyAll(0),
          ),

          SizedBox(height: 20),

          //Best Seller
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best Seller',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return DetailFood(
                              food: food[2],
                            );
                          },
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: MediaQuery.sizeOf(context).width,
                                child: Image.asset(
                                  food[2].imagePath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food[2].name.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  Text(
                                    '${food[2].price} IDR',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: 20),

          //Popular food
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Food',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(right: 10),
                  itemCount: food.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return DetailFood(
                                food: food[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : 0,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              color: Colors.transparent,
                              child: ClipRect(
                                child: Image.asset(
                                  food[index].imagePath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              food[index].name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '${food[index].price} IDR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
