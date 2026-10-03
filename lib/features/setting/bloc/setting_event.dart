part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class GetSettings extends SettingEvent {}

final class UpdateIpAddress extends SettingEvent {
  final String ipAddress;

  const UpdateIpAddress({required this.ipAddress});
  @override
  List<Object> get props => [ipAddress];
}
