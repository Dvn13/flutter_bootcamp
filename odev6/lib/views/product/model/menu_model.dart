class MenuItem {
  final String name;
  final String imageURL;
  final String price;

  MenuItem({required this.name, required this.imageURL, required this.price});
}

class MenuCategory {
  final String name;
  final List<MenuItem> items;

  MenuCategory({required this.name, required this.items});
}
