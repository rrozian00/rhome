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
  final UserModel user;
  final bool isLogout;

  const SettingLoaded({
    required this.appVersion,
    required this.ipAdress,
    required this.user,
    required this.isLogout,
  });

  SettingLoaded copyWith({
    UserModel? user,
    String? appVersion,
    String? ipAddress,
    bool? isLogout,
  }) {
    return SettingLoaded(
      isLogout: isLogout ?? this.isLogout,
      user: user ?? this.user,
      appVersion: appVersion ?? this.appVersion,
      ipAdress: ipAddress ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [appVersion, ipAdress, user, isLogout];
}

final class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});
  @override
  List<Object> get props => [message];
}

// final class SettingLogout extends SettingState {}
