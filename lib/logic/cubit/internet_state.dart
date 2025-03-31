part of 'internet_cubit.dart';

sealed class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

final class InternetLoading extends InternetState {}

final class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  const InternetConnected({required this.connectionType});
}

final class InternetDisconnected extends InternetState {}
