import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'package:smart_coupons/storage/coupons_storage_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_event.dart';

part 'coupon_state.dart';

part 'coupon_bloc.freezed.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(const CouponState()) {
    on<LoadCoupons>(_onLoadCoupons);
    on<AddCoupon>(_onAddCoupon);
    on<DeleteCoupon>(_onDeleteCoupon);
  }

  Future<void> _onLoadCoupons(
    LoadCoupons event,
    Emitter<CouponState> emit,
  ) async {
    emit(state.copyWith(status: CouponStatus.loading));
    try {
      final String categoryId = event.categoryId;
      final coupons = await CouponStorageService.loadCoupons(
        categoryId: categoryId,
      );
      emit(state.copyWith(
        status: CouponStatus.loaded,
        coupons: coupons,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CouponStatus.error,
        errorMessage: "Ошибка загрузки купонов: $e",
      ));
    }
  }

  Future<void> _onAddCoupon(
    AddCoupon event,
    Emitter<CouponState> emit,
  ) async {
    try {
      await CouponStorageService.addCoupon(
        coupon: event.coupon,
        categoryId: event.categoryId,
      );
      final coupons = await CouponStorageService.loadCoupons(
        categoryId: event.categoryId,
      );
      emit(state.copyWith(
        status: CouponStatus.loaded,
        coupons: coupons,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CouponStatus.error,
        errorMessage: "Ошибка добавления купона: $e",
      ));
    }
  }

  Future<void> _onDeleteCoupon(
    DeleteCoupon event,
    Emitter<CouponState> emit,
  ) async {
    try {
      await CouponStorageService.deleteCoupon(
        categoryId: event.categoryId,
        couponId: event.couponId,
      );
      final coupons = await CouponStorageService.loadCoupons(
        categoryId: event.categoryId,
      );
      emit(state.copyWith(
        status: CouponStatus.loaded,
        coupons: coupons,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CouponStatus.error,
        errorMessage: "Ошибка удаления купона: $e",
      ));
    }
  }
}
