
import 'package:barber_app/models/u_shop_worker.dart';

class ShopAbout{
   int shop_id=0;
   String img_url="";
   String type_shop="";
   String name;
   int fav_num=0;
   String address;
   List<ShopWorker>? workers;
   Map<String,String > shopHours;

   ShopAbout({
      required this.address,
      required this.shopHours,
      required this.shop_id,
      required this.name,
      required this.fav_num,
      required this.img_url,
      required this.type_shop,
      required this.workers

   });

   ShopAbout.withOnlyAddress({required this.address, required this.shopHours,required this.name});

   Map<String,dynamic> toMap()=>{
      'shop_id':shop_id,
      'img_url':img_url,
      'type_shop':type_shop,
      'name':name,
      'fav_num':fav_num,
      'address':address,
      'shopHours':shopHours,

   };

   factory ShopAbout.fromMap(Map map){
      return ShopAbout(
         shop_id:map['shop_id'],
         img_url:map['img_url'],
         type_shop:map['type_shop'],
         name:map['name'],
         fav_num:map ['fav_num'],
         address:map ['address'],
         shopHours:map['shopHours'],
         workers: map['workers']
      );
   }


}