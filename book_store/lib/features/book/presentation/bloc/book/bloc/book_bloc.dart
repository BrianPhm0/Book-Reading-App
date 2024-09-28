import 'package:bloc/bloc.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/entities/book_type.dart';
import 'package:book_store/features/book/business/usecases/get_list_book_by_type.dart';
import 'package:book_store/features/book/business/usecases/get_list_book_type_usecase.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetListBookTypeUsecase _bookTypeUsecase;
  final GetListBooksByType _booksByType;

  BookBloc({
    required GetListBookTypeUsecase bookTypeUsecase,
    required GetListBooksByType booksByType,
  })  : _bookTypeUsecase = bookTypeUsecase,
        _booksByType = booksByType,
        super(BookInitial()) {
    on<GetAllBookType>(_onGetAllBookType);
    on<GetBooksByType>(_onGetBooksByType);
    on<ResetBooksState>(_onResetBooksState);
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
      (l) => emit(BookFailure(l.message)),
      (r) => emit(BooksByTypeSuccess(r)),
    );
  }

  void _onResetBooksState(ResetBooksState event, Emitter<BookState> emit) {
    emit(BookInitial()); // Hoặc trạng thái ban đầu mà bạn muốn
  }
}
