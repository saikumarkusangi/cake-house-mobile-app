
class Cart {
   late final int? id;
   final String? name;
   final String? image;
   final int? price;
   final String? unitTag;
   final int? quantity;
   final int? initialPrice;

  Cart({
    required this.image,
    required this.name,
    required this.price,
    required this.id,
    required this.quantity,
    required this.unitTag,
    required this.initialPrice
    
  });
    
Cart.fromMap(Map<dynamic,dynamic> res)

   :id = res['id'],
   image = res['image'],
   price = res['price'],
   unitTag = res['unitTag'],
   quantity = res['quantity'],
   name = res['name'],
   initialPrice = res['initialPrice'];
  Map <String,Object?> toMap(){
    return {
      'image':image,
      'name':name,
      'price':price,
      'id':id,
      'unitTag':unitTag,
      'quantity':quantity,
      'initialPrice':initialPrice,
    };
  }

}
