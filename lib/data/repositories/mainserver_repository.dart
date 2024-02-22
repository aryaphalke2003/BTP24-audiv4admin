import 'package:audiadmin/authentication/resetPassword.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MainRepository {
  final base_url = "https://arya09.pythonanywhere.com/";

  Future<Response> forgotPassword(String email, String password) async {
    var url = base_url + "auth/forgot-password";
    print(url);
    print(email);
    print(password);
    var response = await http
        .post(Uri.parse(url), body: {"email": email, "password": password});

    print(response.body);
    print(response.statusCode);

    return response;
  }

  Future<Response?> sentOTP(String email) async {
    try {
      String url = "https://nodemail-4l1d.onrender.com/sendmail?to=${email}";
      var response = await http.get(Uri.parse(url));

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response> verifyOTP(String email, String OTP) async {
    String url =
        "https://nodemail-4l1d.onrender.com/verifyotp?email=${email}&otp=${OTP}";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response;
  }

  Future<Response> login(String email, String password) async {
    var url = Uri.parse(base_url + "auth/login");
    var response =
        await http.post(url, body: {"email": email, "password": password});
    print("mainrepo $response");
    return response;
  }

  Future<Response> register(
      String name, String email, String organization, String password) async {
    var url = Uri.parse(base_url + "auth/register");
    var response = await http.post(url, body: {
      "name": name,
      "email": email,
      "organization": organization,
      "password": password
    });

    return response;
  }
}
