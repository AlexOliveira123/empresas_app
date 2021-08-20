import '../models/investor_model.dart';

abstract class AuthDatasource {
  Future<InvestorModel> doLogin(String email, String password);
}
