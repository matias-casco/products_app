part of 'check_ethernet_bloc.dart';

abstract class CheckEthernetState {}

class CheckEthernetInitial extends CheckEthernetState {}

class ConnectedState extends CheckEthernetState {
  ConnectedState();
}

class NotConnectedState extends CheckEthernetState {
  NotConnectedState();
}
