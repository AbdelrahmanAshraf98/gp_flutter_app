abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final String uId;

  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);

}

class RegisterLoadingState extends RegisterStates{}

class CreateUserSuccessState extends RegisterStates{}

class CreateUserLoadingState extends RegisterStates{}

class CreateUserErrorState extends RegisterStates{}

class ChangeRegisterPasswordVisibilityState extends RegisterStates{}