import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_ethernet_event.dart';
part 'check_ethernet_state.dart';

class CheckEthernetBloc extends Bloc<CheckEthernetEvent, CheckEthernetState> {
  StreamSubscription? _subscription;
  CheckEthernetBloc() : super(CheckEthernetInitial()) {
    on<CheckEthernetEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(
          ConnectedState(),
        );
      } else if (event is NotConnectedEvent) {
        emit(
          NotConnectedState(),
        );
      }
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        add(NotConnectedEvent());
      } else {
        add(ConnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
