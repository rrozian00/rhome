part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class GetAppVersion extends SettingEvent {}

final class SaveIpAddress extends SettingEvent {
  final String ipAddress;

  const SaveIpAddress({required this.ipAddress});
  @override
  List<Object> get props => [ipAddress];
}

final class GetIpAddress extends SettingEvent {}
