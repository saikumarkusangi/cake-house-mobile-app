const String uri = "https://script.google.com/macros/s/AKfycbySrNCWLjuPgApzqRQ3obrgRKY0WDjs5xl4Lm0nrjSvjKaqrifYSv_IhWR0xkoNb_k/exec";

List images_url = [];

class Item{
 
  Item({required this.name,required this.price,required this.qty});

  String name;
  String price;
  String qty;

  Map<String,dynamic> toMap(){
    return {
      'name' :name,
      'price':price,
      'qty':qty
    };
  }
}

