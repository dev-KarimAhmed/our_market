part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {}

final class GetDataError extends HomeState {}

final class AddToFavoriteLoading extends HomeState {}
final class AddToFavoriteSuccess extends HomeState {}
final class AddToFavoriteError extends HomeState {}

