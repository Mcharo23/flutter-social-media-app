import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/auth/auth_cubit.dart';
import 'package:social_media_app/auth/auth_repository.dart';
import 'package:social_media_app/auth/form_submission_status.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({required this.authRepo, required this.authCubit})
      : super(ConfirmationState()) {
    on<ConfirmationCodeChanged>(_onConfirmationChanged);
    on<ConfirmationSubmitted>(_onSubmitted);
  }

  void _onConfirmationChanged(
      ConfirmationCodeChanged event, Emitter<ConfirmationState> emit) {
    emit(state.copyWith(code: event.code));
  }

  void _onSubmitted(
      ConfirmationSubmitted event, Emitter<ConfirmationState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final userId = await authRepo.confirmSignUp(
          username: authCubit.credentials.username,
          confirmationCode: state.code);
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      final credentials = authCubit.credentials;

      credentials.userId = userId;
      authCubit.launchSession(credentials);
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
    }
  }
}
