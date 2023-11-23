import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:odev6/views/product/model/menu_model.dart';

import 'package:odev6/widget/card_widget.dart';

import 'package:odev6/widget/search_field.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<MenuCategory> categories = [];
  int selectedCategory = 0;
  @override
  void initState() {
    super.initState();
    addProducts();
  }

  void addProducts() {
    categories.add(MenuCategory(name: 'DÜRÜMLER', items: [
      MenuItem(
          name: 'Favori Double Dürüm',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/cig-kofte-durum/cig-kofte-durum.jpg',
          price: '56.50'),
      MenuItem(
          name: 'Favori Ultra Mega Dürüm',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/cig-kofte-durum/cig-kofte-durum.jpg',
          price: '51.50'),
      MenuItem(
          name: 'Favori Mega Çiğ Köfte Dürüm',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/cig-kofte-durum/cig-kofte-durum.jpg',
          price: '46.50'),
      MenuItem(
          name: 'Favori Çiğ Köfte Dürüm',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/cig-kofte-durum/cig-kofte-durum.jpg',
          price: '39.50'),
      MenuItem(
          name: 'Çiğ Köfte Dürüm',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/cig-kofte-durum/cig-kofte-durum.jpg',
          price: '37.50'),
    ]));

    categories.add(MenuCategory(name: 'DÜRÜMLÜ MENÜLER', items: [
      MenuItem(
          name: 'Dürüm Menü',
          imageURL:
              'https://cdn.getiryemek.com/products/1576236465683_500x375.png',
          price: '47.50'),
      MenuItem(
          name: 'Mega Dürüm Menü',
          imageURL:
              'https://cdn.getiryemek.com/products/1576236465683_500x375.png',
          price: '53.50'),
      MenuItem(
          name: 'Ultra Mega Dürüm Menü',
          imageURL:
              'https://cdn.getiryemek.com/products/1576236465683_500x375.png',
          price: '59.50'),
      MenuItem(
          name: 'Double Dürüm Menü',
          imageURL:
              'https://cdn.getiryemek.com/products/1576236465683_500x375.png',
          price: '39.50'),
    ]));

    categories.add(MenuCategory(name: 'ÇİĞ KÖFTE PORSİYONLAR', items: [
      MenuItem(
          name: 'Çiğ Köfte (200 g)',
          imageURL:
              'https://cdn.getiryemek.com/products/1667395245690_500x375.webp',
          price: '57.50'),
      MenuItem(
          name: 'Çiğ Köfte (400 g)',
          imageURL:
              'https://cdn.getiryemek.com/products/1667395245690_500x375.webp',
          price: '99.50'),
      MenuItem(
          name: 'Çiğ Köfte (600 g)',
          imageURL:
              'https://cdn.getiryemek.com/products/1667395245690_500x375.webp',
          price: '142.50'),
      MenuItem(
          name: 'Çiğ Köfte (800 g)',
          imageURL:
              'https://cdn.getiryemek.com/products/1667395245690_500x375.webp',
          price: '186.50'),
    ]));

    categories.add(MenuCategory(name: 'PORSİYON MENÜLER', items: [
      MenuItem(
          name: 'Çiğ Köfte Menü (200 g)',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/44244cc9/44244cc9.jpg',
          price: '57.50'),
      MenuItem(
          name: 'Çiğ Köfte Menü (600 g)',
          imageURL:
              'https://www.komagene.com.tr/Content/Images/Products/44244cc9/44244cc9.jpg',
          price: '99.50'),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    const unSelect = Color.fromARGB(132, 247, 207, 165);
    const select = Color.fromARGB(255, 253, 143, 25);
    const scBgColor = Color.fromRGBO(255, 223, 182, 1);
    const primaryColor = Color.fromRGBO(223, 39, 29, 1);
    return SafeArea(
      child: Scaffold(
        backgroundColor: scBgColor,
        bottomNavigationBar: bottomNavigateBar(primaryColor),
        appBar: appbar(primaryColor),
        body: body(select, unSelect),
      ),
    );
  }

  CurvedNavigationBar bottomNavigateBar(Color primaryColor) {
    return CurvedNavigationBar(
      color: primaryColor,
      backgroundColor: Colors.transparent,
      height: 60,
      items: const <Widget>[
        Icon(
          Icons.card_giftcard_outlined,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.search_rounded,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.home_outlined,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_bag_outlined,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person_2_outlined,
          size: 30,
          color: Colors.white,
        ),
      ],
      onTap: (index) {},
    );
  }

  AppBar appbar(Color color) {
    return AppBar(
      elevation: 0,
      leading: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
      ),
      backgroundColor: color,
      title: const Text(
        'ÜRÜNLER',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 32,
            ),
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Positioned(
                    right: 5,
                    bottom: -1,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color, fontSize: 12),
                      ),
                    )),
              ],
            )
          ],
        )
      ],
    );
  }

  Padding body(Color select, Color unSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          headerList(select, unSelect),
          searchWidget(),
          bodyList(select)
        ],
      ),
    );
  }

  Padding searchWidget() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SearchField(),
    );
  }

  Container headerList(Color select, Color unSelect) {
    return Container(
        height: 175,
        color: Colors.white,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 100,
              child: Column(
                children: [
                  CardWidget(
                    imgUrl: categories[index].items[0].imageURL,
                    bordercolor: selectedCategory == index ? select : unSelect,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categories[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Expanded bodyList(Color select) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories[selectedCategory].items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var items = categories[selectedCategory].items;
          var orange = const Color.fromRGBO(241, 93, 47, 1);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CardWidget(
                      imgUrl: items[index].imageURL,
                      bordercolor: select,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    items[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      '${items[index].price.toString()}TL',
                                      style: TextStyle(
                                          color: orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: orange),
                                  child: const Text(
                                    'Sipariş Ver',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 2,
              )
            ],
          );
        },
      ),
    );
  }
}
