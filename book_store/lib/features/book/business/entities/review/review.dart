import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String comment;
  final String fullName;
  final String email;
  final String avatar;
  final double rating;

  const Review(
      this.comment, this.fullName, this.email, this.avatar, this.rating);

  @override
  List<Object?> get props {
    return [comment, fullName, email, avatar, rating];
  }
}
