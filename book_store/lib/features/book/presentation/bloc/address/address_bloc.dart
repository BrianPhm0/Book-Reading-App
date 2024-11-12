import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:book_store/features/book/business/usecases/address/get_address.dart';
import 'package:book_store/features/book/business/usecases/address/save_address.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final SaveAddress _saveAddress;
  final GetAddress _getAddress;
  AddressBloc({
    required SaveAddress saveAddress,
    required GetAddress getAddress,
  })  : _saveAddress = saveAddress,
        _getAddress = getAddress,
        super(AddressInitial()) {
    on<AddressEvent>(
      (event, emit) {},
    );
    on<SaveAddressEvent>(_onSaveAdress);
    on<GetAddressEvent>(_onGetAdress);
  }

  void _onSaveAdress(SaveAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    final res = await _saveAddress(
        SaveAddressParams(event.name, event.phone, event.address));

    res.fold((failure) => emit(AddressFail(failure.message)),
        (r) => emit(SaveAddressSuccess()));
  }

  void _onGetAdress(GetAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    final res = await _getAddress(NoParams());

    res.fold((failure) => emit(AddressFail(failure.message)),
        (r) => emit(GetAddressSuccess(r)));
  }
}
