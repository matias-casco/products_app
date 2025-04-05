import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_checker_event.dart';
part 'internet_checker_state.dart';

class InternetCheckerBloc extends Bloc<InternetCheckerEvent, InternetCheckerState> {
  StreamSubscription? _subscription;
  InternetCheckerBloc() : super(CheckEthernetInitial()) {
    on<InternetCheckerEvent>((event, emit) {
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
