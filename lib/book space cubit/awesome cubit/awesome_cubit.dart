import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'awesome_state.dart';

class AwesomeCubit extends Cubit<AwesomeState> {
  AwesomeCubit() : super(AwesomeInitial());
}
