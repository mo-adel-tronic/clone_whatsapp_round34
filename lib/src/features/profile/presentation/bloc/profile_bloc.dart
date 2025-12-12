import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'profile_state.dart';
import '../../domain/usecases/usecases.dart';
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;

  ProfileBloc(this.getProfile) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());

      final result = await getProfile("some_user_id"); // Assuming a default or placeholder user ID for now
      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(ProfileError(failure.message ?? 'Server Error'));
        } else {
          emit(ProfileError('Unknown Error'));
        }
      }, (profile) => emit(ProfileLoaded(profile)));
    });
  }
}
