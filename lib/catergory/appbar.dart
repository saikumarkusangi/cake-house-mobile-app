
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cake_house_bakery/controllers/cart_provider.dart';
import 'package:cake_house_bakery/models/cart_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cake_house_bakery/views/cart.dart';
import 'package:cake_house_bakery/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../controllers/product_controller.dart';
import '../db.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class CategoryApp extends StatefulWidget {
  const CategoryApp({Key? key}) : super(key: key);

  @override
  State<CategoryApp> createState() => _CategoryAppState();
}

class _CategoryAppState extends State<CategoryApp>
    with SingleTickerProviderStateMixin {
      Db? db = Db();
     late TabController _controller ;
    
   int _selectedIndex = 0;
   @override
   void initState() { 
     super.initState();
     _controller = TabController(length: 11, vsync: this);
     _controller.addListener(() {
      setState(() {
        _selectedIndex= _controller.index;
      });
   
     });
   }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductController>(context);
    final cartProvider = Provider.of<CartController>(context);
    return SafeArea(
      child: RefreshIndicator(
         onRefresh:() {
                 return productProvider.fetchProducts();
                } ,
        child: CustomScrollView(
          
          slivers: [
           
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              title: Container(
                width: 200,
                height: 80,
                color: Colors.deepOrange,
                child: Center(child: Text('Cake House',style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),))),
              actions: [
                         Padding(
                     padding: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Badge(
                        showBadge: (cartProvider.counter > 0) ? true : false ,
                        alignment: Alignment.topLeft,
                        toAnimate: true,  
                        animationType: BadgeAnimationType.fade,
                        badgeContent: Consumer<CartController>(
                          builder: (context, value, child) {
                            return  Text(value.counter.toString(),style: TextStyle(color: Colors.red),);
                          },
                        ),
                        
                        badgeColor: Colors.white,
                        animationDuration: Duration(milliseconds: 300),
                       child: IconButton(onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (_)=> CartPage()));
                          }, icon: Icon(Icons.card_travel,color: Colors.white,size: 35,)),
                      ),
                    ),
                  ),
          
              ],
              backgroundColor: Colors.deepOrange,  
              pinned: false,
            ),
               SliverAppBar(
                 automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 0,
               toolbarHeight: 100,
            flexibleSpace:SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/top.png',fit: BoxFit.cover,)),
            ),
            SliverAppBar(
              stretch: true,
             
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              pinned: false,
              expandedHeight: 200,
              centerTitle: true,
               automaticallyImplyLeading: false,
              flexibleSpace:  FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                background: Swiper(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) { 
            return 
            (productProvider.isLoading)?                                    Shimmer.fromColors(
                                      baseColor:Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Container(
                                          color: Colors.grey[400],
                                          height: 200,
                                         
                                        ),
                                      ),
                                    ):
            (productProvider.products[index].banners!.isNotEmpty)?
            Image.network(
            productProvider.products[index].banners!,
            fit: BoxFit.cover,
            ):null;
          },
           autoplay: true,
        )),
              ),
            
           
            SliverAppBar(
               automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 0,
              toolbarHeight: 100,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: TabBar(
                      automaticIndicatorColorAdjustment: true,
                      controller: _controller,
                      indicatorColor: Colors.deepOrange,
                      labelColor: Colors.deepOrange,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.only(right: 45.0),
                      unselectedLabelColor: Color(0xFFCDCDCD),
                      indicatorPadding: EdgeInsets.only(right: 40),
                      indicatorWeight: 3,
                      tabs: [
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/pastri.png',
                                scale: 8,
                              ),
                              const Text('Pastri',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/specialcake.png',
                                scale: 8,
                              ),
                              const Text('Cake',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/burger.png',
                                scale: 8,
                              ),
                              const Text('Burger',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/cooldrink.png',
                                scale: 8,
                              ),
                              const Text('Drinks',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                       
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/pizza.png',
                                scale: 8,
                              ),
                              const Text('Pizza',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                          SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/chocolates.png',
                                scale: 8,
                              ),
                              const Text('Chocolates',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                       
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/icecream.png',
                                scale: 8,
                              ),
                              const Text('Ice Cream',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/party_kit.png',
                                scale: 8,
                              ),
                              const Text('Party Kit',
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 21.0,
                                  ))
                            ],
                          ),
                        ),
                       
                       
                      ]),
                ),
              ),
            ),
           
          
            SliverList(
              
              delegate: SliverChildBuilderDelegate((context, index) {
             
                return (productProvider.isLoading == false)?
                
                 Column(
                  
                         children:   [
                (_controller.index == 0 && productProvider.products[index].caterory!.trim()  =='pastri' ||
                 _controller.index == 1 && productProvider.products[index].caterory!.trim()  =='cake'
                 ||_controller.index == 2 && productProvider.products[index].caterory!.trim()  =='burger' ||
                 _controller.index == 3 && productProvider.products[index].caterory!.trim()  =='drinks' ||
                 _controller.index == 4 && productProvider.products[index].caterory!.trim()  =='pizza' || 
                 _controller.index == 5 && productProvider.products[index].caterory!.trim()  =='chocolates' || 
                 _controller.index == 6 && productProvider.products[index].caterory!.trim()  =='icecream' || 
                 _controller.index == 7 && productProvider.products[index].caterory!.trim()  =='partykit' 
 
                  )?
                 GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailsPage(
                      image: productProvider.products[index].image!,
                     unitTag: productProvider.products[index].name!,
                     id: index,
                     quantity :1,
                     initialPrice: productProvider.products[index].price!,
                      price: productProvider.products[index].price!,
                      name: productProvider.products[index].name!,
                      description: productProvider.products[index].description!,
                      offer: productProvider.products[index].offer!,
                    )));
                  },
                   child: 
                   
                   Container(
                    color: Colors.white,
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                     child: Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                     
                       Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:
                         [
                            SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
   
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Hero(
                                tag: productProvider.products[index].name ?? 'something went wrong',
                                child: CachedNetworkImage(
                                   errorWidget: (context, url, error) => Image.network('https://demofree.sirv.com/products/123456/123456.jpg?profile=error-example'),
                                  imageUrl:productProvider.products[index].image!,fit: BoxFit.cover,))),
                          ) ,
                        
                         SizedBox(width: 10,),
                         SizedBox(
                          height: 150,
                           child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               
                                 Container(
                                 width: MediaQuery.of(context).size.width/2,
                                   child: Text(
                                    productProvider.products[index].name ?? 'something went wrong',
                                   style: TextStyle(
                                    fontSize: 22,fontWeight: FontWeight.w600
                                   ),
                                     overflow: TextOverflow.ellipsis,
                                   maxLines: 2,),
                                 ),
                         
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        (productProvider.products[index].price2! != 0)?
                                        Text('₹ ${productProvider.products[index].price2!.toString()}',
                               style: TextStyle(
                                decorationThickness: 3,
                                decoration: TextDecoration.lineThrough,
                                        color: Colors.black54,
                                        fontSize: 18,fontWeight: FontWeight.w600
                               ),
                              ):SizedBox(height: 0,width: 0,),
                              Text('₹ ${productProvider.products[index].price!.toString()}',
                               style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,fontWeight: FontWeight.w600
                               ),),
                                      ],
                                    ),
                               
                               SizedBox(width: 10,),
                                  SizedBox(
                            height: 50,
                            child: (productProvider.products[index].offer!.isEmpty) ?
                            
                             Image.network('https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734',height: 1,width: 1,):
                             Image.network(productProvider.products[index].offer!)  ) 
                                  ],
                                ),
          
                               MaterialButton(
                                textColor: Colors.white,
                                color: Colors.deepOrange,
                                onPressed: (){
          
                                db!.insert(
                                  Cart(
                                    initialPrice: productProvider.products[index].price,
                                    image: productProvider.products[index].image,
                                     name: productProvider.products[index].name, 
                                     price: productProvider.products[index].price, 
                                     id: index, 
                                     quantity: 1, 
                                     unitTag: productProvider.products[index].name
                                     )
                                ).then((value) {
                                      cartProvider.addtotalPrice(productProvider.products[index].price!);
                                    
                                      cartProvider.addCounter();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Added to Bag'),
                         ) );
                                }).onError((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Already added to Bag'),
                         ) );
                                });
                               
                             },
                             
                             minWidth: 50,
                             height: 40,
                             child: Text('ADD TO BAG',style: TextStyle(fontSize: 20),))
                             ],
                           ),
                         ),
                        
                        ]
                          
                      
                      )
                               ),
                   )
                 ):SizedBox(height: 0,)
                ]
                ):  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(  
                  
                                children: [
                                    Shimmer.fromColors(
                                      baseColor:Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        color: Colors.grey[400],
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                            baseColor:Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                          child: Container(
                                            height: 20,width: 140,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         Shimmer.fromColors(
                                            baseColor:Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                           child: Container(
                                         
                                            height: 20,width: 50,
                                            color: Colors.grey[400],
                                                                               ),
                                         )
                                      ],
                                    )
                                ],
                               ),
                );
              }, childCount: productProvider.length),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(String name, String price, String imgPath) {
  return InkWell(
    onTap: () {
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => CookieDetail(
      //       assetPath: imgPath,
      //       cookieprice:price,
      //       cookiename: name
      //     )));
    },
    child: 
        Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width/2.5,
              height: 200,
              child: Image.network(imgPath,fit: BoxFit.cover,));
          }
        ),
        
     
  );
}
