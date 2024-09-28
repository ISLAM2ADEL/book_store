import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? img = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
    );
    if (img != null) {
      emit(SettingsImagePicked(File(img.path)));
    }
  }
}
