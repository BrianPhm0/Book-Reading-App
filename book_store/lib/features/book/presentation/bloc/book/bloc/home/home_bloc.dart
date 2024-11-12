import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/usecases/home/best_deal.dart';
import 'package:book_store/features/book/business/usecases/home/latest_book.dart';
import 'package:book_store/features/book/business/usecases/home/top_book.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //implement use case
  final LatestBook _latestBook;
  final TopBook _topBook;
  final BestDeal _bestDeal;

  HomeBloc(
      {required LatestBook latestBook,
      required TopBook topBook,
      required BestDeal bestDeal})
      : _latestBook = latestBook,
        _topBook = topBook,
        _bestDeal = bestDeal,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetHomeBookEvent>(_onGetHomeBook);
  }

  Future<void> _onGetHomeBook(
      GetHomeBookEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    // Call use case to get the latest books and top books
    final latestResult = await _latestBook(NoParams());
    final topResult = await _topBook(NoParams());
    final bestDeal = await _bestDeal(NoParams());

    // Check the result of both use cases
    if (latestResult.isRight() && topResult.isRight() && bestDeal.isRight()) {
      // Cast each result to List<BookItem> to avoid type issues
      final latestBooks =
          latestResult.fold((_) => <BookItem>[], (books) => books);
      final topBooks = topResult.fold((_) => <BookItem>[], (books) => books);
      final bestDeal = topResult.fold((_) => <BookItem>[], (books) => books);

      emit(HomeSuccess(
          latestBooks: latestBooks, topBooks: topBooks, bestDeal: bestDeal));
    } else {
      emit(const HomeFailure('Failed to fetch books'));
    }
  }
}
