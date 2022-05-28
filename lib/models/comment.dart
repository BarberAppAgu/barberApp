class Comment {
  int? commentId;
  int shopId;
  int userId;
  String detail;
  String date;
  String detailedDate;

  Comment({
    this.commentId,
    required this.shopId,
    required this.userId,
    required this.detail,
    required this.date,
    required this.detailedDate,
  });

  factory Comment.fromMap(Map map) {
    return Comment(
      commentId: int.parse(map['comment_id']),
      shopId: int.parse(map['shop_id']),
      userId: int.parse(map['user_id']),
      detail: map['detail'],
      date: map['date'],
      detailedDate: map['detailed_date'],
    );
  }
}
