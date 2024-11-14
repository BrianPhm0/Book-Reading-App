import 'package:book_store/features/book/business/entities/review/review.dart';

class ReviewModel extends Review {
  const ReviewModel(
      super.comment, super.fullName, super.email, super.avatar, super.rating);
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      json['comment'] ?? '',
      json['username'] ?? '',
      json['email'] ?? '',
      json['avatar'] ?? '',
      json['rating'] ?? 0,
    );
  }
}
