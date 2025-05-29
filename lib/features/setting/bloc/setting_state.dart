part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

final class SettingLoading extends SettingState {}

final class SettingLoaded extends SettingState {
  final String appVersion;
  final String ipAdress;

  const SettingLoaded({required this.appVersion, required this.ipAdress});

  SettingLoaded copyWith({
    // required SettingLoaded current,
    String? appVersion,
    String? ipAddress,
  }) {
    return SettingLoaded(
      appVersion: appVersion ?? this.appVersion,
      ipAdress: ipAddress ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [appVersion, ipAdress];
}

final class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});
  @override
  List<Object> get props => [message];
}
