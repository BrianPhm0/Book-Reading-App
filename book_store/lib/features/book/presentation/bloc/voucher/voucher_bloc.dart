import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/business/usecases/voucher/add_voucher.dart';
import 'package:book_store/features/book/business/usecases/voucher/get_public_voucher.dart';
import 'package:book_store/features/book/business/usecases/voucher/get_voucher.dart';
import 'package:equatable/equatable.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final Getvoucher _getvoucher;
  final GetPublicVoucher _getPublicVoucher;
  final AddVoucher _addVoucher;

  VoucherBloc({
    required Getvoucher getvoucher,
    required GetPublicVoucher getPublicVoucher,
    required AddVoucher addVoucher,
  })  : _getvoucher = getvoucher,
        _getPublicVoucher = getPublicVoucher,
        _addVoucher = addVoucher,
        super(VoucherInitial()) {
    on<VoucherEvent>((event, emit) {});
    on<GetVoucherEvent>(_onGetVoucher);
    on<GetPublicVoucherEvent>(_onGetPublicVoucher);
    on<AddVoucherEvent>(_onAddVoucher);
  }

  void _onGetVoucher(GetVoucherEvent event, Emitter<VoucherState> emit) async {
    emit(VoucherLoading());

    final res = await _getvoucher(NoParams());

    return res.fold((l) {
      emit(VoucherFailure(l.message));
    }, (r) {
      emit(GetVoucherSuccess(r));
    });
  }

  void _onGetPublicVoucher(
      GetPublicVoucherEvent event, Emitter<VoucherState> emit) async {
    emit(VoucherLoading());

    final res = await _getPublicVoucher(NoParams());

    return res.fold((l) {
      emit(VoucherFailure(l.message));
    }, (r) {
      emit(GetPublicVoucherSuccess(r));
    });
  }

  void _onAddVoucher(AddVoucherEvent event, Emitter<VoucherState> emit) async {
    emit(VoucherLoading());

    final res = await _addVoucher(AddVoucherParams(event.id));

    return res.fold((l) {
      emit(VoucherFailure(l.message));
    }, (r) {
      emit(AddVoucherSuccess());
    });
  }
}
