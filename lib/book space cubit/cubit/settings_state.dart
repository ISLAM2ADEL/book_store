part of 'settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingLoading extends SettingsState {}

class SettingSuccess extends SettingsState {
  final String data;

  SettingSuccess(this.data);
}

class SettingFailure extends SettingsState {
  final String message;

  SettingFailure(this.message);
}

class SettingsImagePicked extends SettingsState {
  final File imageFile;

  SettingsImagePicked(this.imageFile);
}
