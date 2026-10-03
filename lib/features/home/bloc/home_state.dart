import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeLoaded extends HomeState {
  final String ipAddress;
  final bool isConnected;
  final List<String> relayNames;
  final List<bool> relayStates;
  final List<String> imagePath;

  const HomeLoaded({
    required this.ipAddress,
    required this.isConnected,

    required this.relayNames,
    required this.relayStates,
    required this.imagePath,
  });

  HomeLoaded copyWith({
    String? ipAddress,
    bool? isConnected,
    List<String>? relayNames,
    List<bool>? relayStates,
    List<String>? imagePath,
  }) {
    return HomeLoaded(
      ipAddress: ipAddress ?? this.ipAddress,
      isConnected: isConnected ?? this.isConnected,
      relayNames: relayNames ?? List.of(this.relayNames),
      relayStates: relayStates ?? List.of(this.relayStates),
      imagePath: imagePath ?? List.of(this.imagePath),
    );
  }

  factory HomeLoaded.initial() {
    return const HomeLoaded(
      ipAddress: "",
      isConnected: false,
      relayNames: ["", "", "", ""],
      relayStates: [false, false, false, false],
      imagePath: ["", "", "", ""],
    );
  }

  @override
  List<Object> get props => [isConnected, relayNames, relayStates, imagePath];
}
