import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chiru/app/models/user.dart';
import 'package:chiru/app/services/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoading(isLoading: true));

      try {
        final UserModel? user = await authService.signUpUser(
          event.email,
          event.password,
        );

        if (user != null) {
          emit(AuthenticationSuccess(user));
        } else {
          emit(const AuthenticationFailure('Create user failed'));
        }
      } catch (e) {
        log(e.toString());
      }

      emit(AuthenticationLoading(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      emit(AuthenticationLoading(isLoading: true));

      try {
        await authService.signOutUser();
      } catch (e) {
        log("Error: $e");
      }

      emit(AuthenticationLoading(isLoading: false));
    });
  }
}
