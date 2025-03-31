import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late final Connectivity connectivity;
  late StreamSubscription connectivitySubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        emitInternetDisConnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisConnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}
