import 'package:flutter_bloc/flutter_bloc.dart';

import 'auto_evento.dart';
import 'auto_estado.dart';

class AutoBloc extends Bloc<AutoEvento, AutoEstado> {
  AutoBloc() : super(AutoInicial()) {
    on<EntrarSemContaEvento>((event, emit) {
      emit(ConvidadoAutenticadoEstado());
    });
  }
}
