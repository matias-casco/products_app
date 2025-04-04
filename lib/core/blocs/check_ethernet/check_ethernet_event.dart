part of 'check_ethernet_bloc.dart';

abstract class CheckEthernetEvent {}

class ConnectedEvent extends CheckEthernetEvent {}

class NotConnectedEvent extends CheckEthernetEvent {}
