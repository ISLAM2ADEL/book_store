part of 'settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsImagePicked extends SettingsState {
  final File imageFile;

  SettingsImagePicked(this.imageFile);
}
