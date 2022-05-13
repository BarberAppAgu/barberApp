

class ShopWorker{

 int worker_id=0;
 int shop_id=0;
 String worker_name="";
 int fav_num=0;

 ShopWorker({required this.fav_num,required this.shop_id,required this.worker_id,required this.worker_name});

 ShopWorker.withName(this.worker_name);

 }