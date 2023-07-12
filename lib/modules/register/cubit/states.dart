abstract class RegisterStates{}

class initialRegisterState extends RegisterStates {}

class userRegisterLoadingState extends RegisterStates {}

class userRegisterSucsessState extends RegisterStates {}

class userRegisterErrorState extends RegisterStates {
  final error;

  userRegisterErrorState(this.error);
}

class userCreateLoadingState extends RegisterStates {}

class userCreateSucsessState extends RegisterStates {}

class userCreateErrorState extends RegisterStates {
  final error;

  userCreateErrorState(this.error);
}

class changePasswordRegisterVisablityState extends RegisterStates {}