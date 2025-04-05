part of 'internet_checker_bloc.dart';

abstract class InternetCheckerEvent {}

class ConnectedEvent extends InternetCheckerEvent {}

class NotConnectedEvent extends InternetCheckerEvent {}
