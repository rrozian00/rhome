import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

// class HomeOffState extends HomeState {}

class HomeLoaded extends HomeState {
  final bool isConnected;
  final List<String> relayNames;
  final List<bool> relayStates;
  final List<String> imagePath;

  const HomeLoaded({
    required this.isConnected,
    required this.relayNames,
    required this.relayStates,
    required this.imagePath,
  });

  @override
  List<Object> get props => [isConnected, relayNames, relayStates, imagePath];

  HomeLoaded copyWith({
    bool? isConnected,
    List<String>? relayNames,
    List<bool>? relayStates,
    List<String>? imagePath,
  }) {
    return HomeLoaded(
      isConnected: isConnected ?? this.isConnected,
      relayNames: relayNames ?? this.relayNames,
      relayStates: relayStates ?? this.relayStates,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

// State untuk menangani error
class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
