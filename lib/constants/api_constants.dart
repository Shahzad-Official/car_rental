class ApiConstants {
  //This is a local ip address
  //Use server ip here after deploying the api on the cloud
  static const baseUrl = "http://192.168.123.70:3000";

  //auth endpoints
  static const login = "/auth/login";
  static const signUp = "/auth/signUp";
  static const sendOtp = "/auth/send_otp";
  static const verifyOtp = "/auth/verify_otp";

  //user endpoints
  static const resetPassword = "/user/resetPassword";
  static const updateProfile = "/user/updateProfile";
  static const updateStatus = "/user/updateStatus";

  //car endpoints
  static const myCars = "/car/user";
  static const car = "/car";

  //brand endpoints
  static const brand = "/brand";
  static const brandCars = "/brand/cars";

  //Bookings endpoints
  static const booking = "/booking";
}
