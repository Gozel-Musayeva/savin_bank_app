import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/language_model.dart';

/// Chosen app language. Provided in `main.dart` so the choice survives
/// leaving the Language screen; read with `context.read<LanguageCubit>()`.
class LanguageCubit extends Cubit<LanguageModel> {
  LanguageCubit() : super(LanguageModel.english);

  void select(LanguageModel language) => emit(language);
}
