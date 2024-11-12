import 'package:bloc/bloc.dart';
import 'package:book_store/features/book/business/usecases/check/pay_cash.dart';
import 'package:equatable/equatable.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  final PayCash _payCash;

  CheckBloc({required PayCash payCash})
      : _payCash = payCash,
        super(CheckInitial()) {
    on<CheckEvent>((event, emit) {});
    on<PayCashEvent>(_onPayCash);
    on<ResetCheckEvent>(_onResetCheck);
  }

  void _onPayCash(PayCashEvent event, Emitter<CheckState> emit) async {
    emit(CheckLoading());

    final res = await _payCash(
        PayCashParams(event.name, event.phone, event.address, event.voucher));
    return res.fold(
      // ignore: void_checks
      (failure) {
        emit(CheckFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      // ignore: void_checks
      (r) {
        emit(CheckSuccess());
        return "Success"; // Return success message or data as a String
      },
    );
  }

  void _onResetCheck(ResetCheckEvent event, Emitter<CheckState> emit) {
    emit(CheckInitial()); // Reset the state to CheckInitial
  }
}
