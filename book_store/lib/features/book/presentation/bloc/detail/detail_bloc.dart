import 'package:bloc/bloc.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/review/review.dart';
import 'package:book_store/features/book/business/usecases/detail/get_detail.dart';
import 'package:book_store/features/book/business/usecases/detail/get_review.dart';
import 'package:book_store/features/book/business/usecases/detail/post_review.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetail _getDetail;
  final GetReview _getReview;
  final PostReview _postReview;

  DetailBloc({
    required GetDetail getDetail,
    required GetReview getReview,
    required PostReview postReview,
  })  : _getDetail = getDetail,
        _getReview = getReview,
        _postReview = postReview,
        super(DetailInitial()) {
    on<DetailEvent>((event, emit) {});
    on<GetDetailEvent>(_onGetDetail);
    on<PostReviewEvent>(_onPostReviewEvent);
  }

  void _onGetDetail(GetDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());

    // Call use case to get the latest books and top books
    final getDetailResult = await _getDetail(DetailParams(id: event.id));
    final getReviewResult = await _getReview(ReviewParams(id: event.id));

    // Check the result of both use cases
    if (getDetailResult.isRight() && getReviewResult.isRight()) {
      final detailBook = getDetailResult.fold(
        (_) => null, // Return null if there's an error
        (book) => book, // Return the BookItem directly
      );

      // Handle the case where detailBook is null
      if (detailBook == null) {
        emit(const DetailFailure('Failed to fetch book details'));
      } else {
        final review =
            getReviewResult.fold((_) => <Review>[], (reviews) => reviews);
        emit(DetailSuccess(detailBook, review));
      }
    } else {
      emit(const DetailFailure('Failed to fetch books'));
    }
  }

  void _onPostReviewEvent(
      PostReviewEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());

    final res = await _postReview(
        PostReviewParams(event.id, event.rating, event.comment));

    res.fold(
      (failure) {
        emit(DetailFailure(failure.message)); // emit failure state
      },
      (r) {
        emit(PostReviewSuccess()); // emit success state
      },
    );
  }
}
