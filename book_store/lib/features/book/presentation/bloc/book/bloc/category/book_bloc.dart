import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book/book.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/categorybook/book_type.dart';
import 'package:book_store/features/book/business/usecases/book/get_latest_book.dart';
import 'package:book_store/features/book/business/usecases/book/get_list_book_by_type.dart';
import 'package:book_store/features/book/business/usecases/book/get_list_book_type_usecase.dart';
import 'package:book_store/features/book/business/usecases/book/get_purchase_book.dart';
import 'package:book_store/features/book/business/usecases/book/search_book.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetListBookTypeUsecase _bookTypeUsecase;
  final GetListBooksByType _booksByType;
  final GetLatestBook _latestBook;
  final GetPurchaseBook _purchaseBook;
  final SearchBook _searchBook;

  BookBloc({
    required GetListBookTypeUsecase bookTypeUsecase,
    required GetListBooksByType booksByType,
    required GetLatestBook latestBook,
    required GetPurchaseBook purchaseBook,
    required SearchBook searchBook,
  })  : _bookTypeUsecase = bookTypeUsecase,
        _booksByType = booksByType,
        _latestBook = latestBook,
        _purchaseBook = purchaseBook,
        _searchBook = searchBook,
        super(BookInitial()) {
    on<GetAllBookType>(_onGetAllBookType);
    on<GetBooksByType>(_onGetBooksByType);
    on<ResetBooksState>(_onResetBooksState);
    on<GetLatestBookEvent>(_onGetLatestBook);
    on<GetPurchaseBookEvent>(_onGetPurchaseBook);
    on<SearchBookEvent>(_onSearchBook);
  }

  void _onGetLatestBook(
      GetLatestBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _latestBook(NoParams());
    res.fold(
        (l) => emit(BookFailure(l.message)), (r) => emit(LatestBookSuccess(r)));
  }

  void _onGetAllBookType(GetAllBookType event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _bookTypeUsecase(GetListBookTypeParams());
    res.fold(
      (l) => emit(BookFailure(l.message)),
      (r) => emit(BookTypeSuccess(r)),
    );
  }

  void _onGetBooksByType(GetBooksByType event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _booksByType(BooksByTypeParam(event.bookIdType));
    res.fold(
      (l) => emit(BookItemFail()),
      (r) => emit(BookItemSuccess(r)),
    );
  }

  void _onResetBooksState(ResetBooksState event, Emitter<BookState> emit) {
    emit(BookInitial()); // Hoặc trạng thái ban đầu mà bạn muốn
  }

  void _onGetPurchaseBook(
      GetPurchaseBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _purchaseBook(NoParams());
    res.fold(
      (l) => emit(BookFailure(l.message)),
      (r) => emit(PurchaseBookSuccess(r)),
    );
  }

  void _onSearchBook(SearchBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _searchBook(
        SearchBookParams(event.name, event.pageNumber, event.pageSize));
    res.fold(
      (l) => emit(BookFailure(l.message)),
      (r) => emit(SearchBookSuccess(r)),
    );
  }
}
