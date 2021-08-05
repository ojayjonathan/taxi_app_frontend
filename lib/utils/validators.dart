String phoneValidator(value) {
  if (value.isEmpty) {
    return "Required";
  } else if (value.length != 10) {
    return "Please provide valid phone number eg 0712234576";
  } else {
    return null;
  }
}

String passwordValidator(value) {
  if (value.isEmpty) {
    return "Required";
  } else if (value.length < 6) {
    return "Should be atleast 6 characters";
  } else if (value.length > 15) {
    return "Should be atmost 15 characters";
  } else {
    return null;
  }
}