part of 'internet_checker_bloc.dart';

abstract class InternetCheckerState {}

class CheckEthernetInitial extends InternetCheckerState {}

class ConnectedState extends InternetCheckerState {
  ConnectedState();
}

class NotConnectedState extends InternetCheckerState {
  NotConnectedState();
}
