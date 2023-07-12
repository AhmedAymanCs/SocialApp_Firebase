abstract class LoginStates{}

class initialLoginState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucsessState extends LoginStates {
  final uId;

  LoginSucsessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final error;

  LoginErrorState(this.error);
}

class changePasswordVisablityState extends LoginStates {}