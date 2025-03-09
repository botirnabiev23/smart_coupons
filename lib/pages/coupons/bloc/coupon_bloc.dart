import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'package:smart_coupons/storage/coupons_storage_service.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponsInitial()) {
    on<LoadCoupons>(_onLoadCoupons);
    on<AddCoupon>(_onAddCoupon);
    on<DeleteCoupon>(_onDeleteCoupon);
  }
  Future<void> _onLoadCoupons(LoadCoupons event, Emitter<CouponState> emit) async {
    try {
      final coupons = await CouponStorageService.loadCoupons();
      emit(CouponsLoaded(coupons));
    } catch (e) {
      emit(CouponsError("Ошибка загрузки купонов: $e"));
    }
  }

  Future<void> _onAddCoupon(AddCoupon event, Emitter<CouponState> emit) async {
    try {
      await CouponStorageService.addCoupon(event.coupon);
      final coupons = await CouponStorageService.loadCoupons();
      emit(CouponsLoaded(coupons));
    } catch (e) {
      emit(CouponsError("Ошибка добавления купона: $e"));
    }
  }

  Future<void> _onDeleteCoupon(DeleteCoupon event, Emitter<CouponState> emit) async {
    try {
      await CouponStorageService.deleteCoupon(event.id);
      final coupons = await CouponStorageService.loadCoupons();
      emit(CouponsLoaded(coupons));
    } catch (e) {
      emit(CouponsError("Ошибка удаления купона: $e"));
    }
  }
}
