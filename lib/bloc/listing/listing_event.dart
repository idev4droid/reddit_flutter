import 'package:equatable/equatable.dart';

abstract class ListingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends ListingEvent {

}
