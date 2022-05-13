class ShopComments{

  int commentId=0;
  int shopId=0;
  int userId=0;
  String detail="";
  String date="";

  ShopComments_withAll( int commentId,
  int shopId,
  int userId,
  String detail,
  String date){
    this.commentId=commentId;
    this.date=date;
    this.detail=detail;
    this.shopId=shopId;
    this.userId=userId;
  }
  ShopComments.withBasic(  String detail,  String date

  ){
  this.date=date;
  this.detail=detail;
  }


 // String strDt = "1984–04–02";
 // DateTime parseDt = DateTime.parse(strDt);
  //print(parseDt); // 1984–04–02 00:00:00.000
 }