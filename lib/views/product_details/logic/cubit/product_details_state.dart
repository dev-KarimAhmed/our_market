part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetRateLoading extends ProductDetailsState {}

final class GetRateSuccess extends ProductDetailsState {}

final class GetRateError extends ProductDetailsState {}

final class AddOrUpdateRateLoading extends ProductDetailsState {}
final class AddOrUpdateRateSuccess extends ProductDetailsState {}
final class AddOrUpdateRateError extends ProductDetailsState {}

final class AddCommentLoading extends ProductDetailsState {}
final class AddCommentSuccess extends ProductDetailsState {}
final class AddCommentError extends ProductDetailsState {}
