// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

String? firebaseExceptionmessage(Exception exception) {
  if (exception is FirebaseException) {
    switch (exception.message) {
      case "The email address is badly formatted.":
        print("Invalid Email");
        return "Enter a Valid Email";
      case "Given String is empty or null.":
        print("Missing Email");
        return "Enter a Valid Email";
      case "The caller does not have permission to execute the specified operation.":
        print("Missing Email");
        return "No Permission \n Contact the Developer";
      default:
    }
    print(exception);
    return exception.message;
  }
  return exception.toString();
}

String snapshotError(String error) {
  print(error);

  switch (error) {
    case "The email address is badly formatted.":
      print("Invalid Email");
      return "Enter a Valid Email";
  }
  return error;
}
