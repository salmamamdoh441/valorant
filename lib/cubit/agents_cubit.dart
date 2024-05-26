import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'agents_state.dart';

class AgentsCubit extends Cubit<AgentsState> {
  AgentsCubit() : super(AgentsInitial());
}
