import 'package:equatable/equatable.dart';

abstract class RelayState extends Equatable {
  const RelayState();

  @override
  List<Object> get props => [];
}

class RelayInitial extends RelayState {}

class RelayLoading extends RelayState {}

// class RelayOffState extends RelayState {}

class RelayLoaded extends RelayState {
  final bool isConnected;
  final List<String> relayNames;
  final List<bool> relayStates;
  final List<String> imagePath;
  // final List<String> icons;

  const RelayLoaded({
    required this.isConnected,
    required this.relayNames,
    required this.relayStates,
    required this.imagePath,
    // required this.icons,
  });

  @override
  List<Object> get props => [
    isConnected,
    relayNames,
    relayStates,
    imagePath,
    // icons,
  ];

  RelayLoaded copyWith({
    bool? isConnected,
    List<String>? relayNames,
    List<bool>? relayStates,
    List<String>? imagePath,
    // List<String>? icons,
  }) {
    return RelayLoaded(
      isConnected: isConnected ?? this.isConnected,
      relayNames: relayNames ?? this.relayNames,
      relayStates: relayStates ?? this.relayStates,
      imagePath: imagePath ?? this.imagePath,
      // icons: icons ?? this.icons,
    );
  }
}

// State untuk menangani error
class RelayError extends RelayState {
  final String message;

  const RelayError({required this.message});

  @override
  List<Object> get props => [message];
}
