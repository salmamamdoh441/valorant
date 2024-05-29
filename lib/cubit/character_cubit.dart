import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valorant/data/model/character_model.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterInitial());
}
